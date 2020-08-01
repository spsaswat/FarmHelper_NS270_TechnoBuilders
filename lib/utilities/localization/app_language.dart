import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(kSupportedLanguages.first);

  Locale get appLocal => _appLocale ?? Locale(kSupportedLanguages.first);
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale(kSupportedLanguages.first);
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (kSupportedLanguages.contains(type.languageCode)) {
      _appLocale = type;
      await prefs.setString('language_code', type.languageCode);
    } else {
      _appLocale = Locale(kSupportedLanguages.first);
      await prefs.setString('language_code', kSupportedLanguages.first);
    }
    notifyListeners();
  }
}
