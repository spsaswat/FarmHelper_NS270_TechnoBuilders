import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/localization/app_language.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String district;
  List<bool> isSelected = List.filled(kSupportedLanguages.length, false);

  DropdownButton<String> districtsDropdown() {
    List<DropdownMenuItem<String>> districtsItems = [];

    for (String s in kDistricts) {
      var newItem = DropdownMenuItem(
        child: Text(AppLocalizations.of(context).translate('kDistricts.' + s)),
        value: s,
      );
      districtsItems.add(newItem);
    }

    return DropdownButton<String>(
      value: district,
      hint: Text(AppLocalizations.of(context).translate('kDistricts.default')),
      underline: SizedBox(),
      items: districtsItems,
      onChanged: (value) {
        setState(() {
          district = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    isSelected[kSupportedLanguages.indexOf(appLanguage.appLocal.languageCode)] =
        true;
    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      bottomNavigationBar: NavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child: TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {},
              decoration: kBoxfield.copyWith(
                hintText: AppLocalizations.of(context)
                    .translate('profile.nameTextHint'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: districtsDropdown(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                ),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8.0),
                textStyle: TextStyle(fontWeight: FontWeight.w600),
                children: <Widget>[
                  for (String languageName in kLanguageNames)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(languageName),
                    )
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                  appLanguage
                      .changeLanguage(Locale(kSupportedLanguages[index]));
                },
                isSelected: isSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
