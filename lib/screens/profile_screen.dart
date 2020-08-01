import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/database_helper.dart';
import 'package:farmhelper/utilities/localization/app_language.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  static String id = 'profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseUser user;
  String registeredPhoneNumber,
      savedName,
      savedFieldArea,
      savedDistrict,
      changedName,
      changedFieldArea,
      changedDistrict;
  List<bool> isSelected = List.filled(kSupportedLanguages.length, false);

  //region getUserDetails
  void getUserDetails() async {
    user = await _auth.currentUser();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      registeredPhoneNumber = (user.phoneNumber);
      savedName = _prefs.getString(kUserNameSharedPrefsKey);
      savedFieldArea = _prefs.getString(kFieldAreaSharedPrefsKey);
      savedDistrict = _prefs.getString(kDistrictSharedPrefsKey);
      changedDistrict = savedDistrict;
    });
  }
  //endregion

  //region updateSharedPreferences
  void updateUserDetailsSharedPreferences(
      String userName, String fieldArea, String districtName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (userName != null) _prefs.setString(kUserNameSharedPrefsKey, userName);
    if (fieldArea != null)
      _prefs.setString(kFieldAreaSharedPrefsKey, fieldArea);
    if (districtName != null)
      _prefs.setString(kDistrictSharedPrefsKey, districtName);
    getUserDetails();
  }
  //endregion

  //region districtsDropdown
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
      value: changedDistrict,
      hint: Text(AppLocalizations.of(context).translate('kDistricts.default')),
      underline: SizedBox(),
      items: districtsItems,
      onChanged: (value) {
        setState(() {
          changedDistrict = value;
        });
      },
    );
  }
  //endregion

  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    isSelected[kSupportedLanguages.indexOf(appLanguage.appLocal.languageCode)] =
        true;
    TextEditingController nameController = TextEditingController()
      ..text = savedName;
    TextEditingController areaController = TextEditingController()
      ..text = savedFieldArea;

    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      appBar: commonAppBar(context),
      bottomNavigationBar: NavBar(),
      body: ListView(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context).translate('profile.title'),
              style: kOptionstyles2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => changedName = value,
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
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child: TextField(
              controller: areaController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                changedFieldArea = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: AppLocalizations.of(context)
                    .translate('profile.areaTextHint'),
                suffixText:
                    AppLocalizations.of(context).translate('profile.areaUnits'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Phone: $registeredPhoneNumber",
                  style: kOptionstyles2,
                  textAlign: TextAlign.center,
                ),
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
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Builder(
              builder: (context) => Button(
                buttonColor: Color(0xFF53d45b),
                buttonText: AppLocalizations.of(context)
                    .translate('profile.saveChanges'),
                onPress: () async {
                  if (changedName == '') {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context).translate(
                          'error.nameValidationSnackbar',
                          [kPhoneNumberLength.toString()]),
                      backgroundColor: Colors.redAccent,
                    );
                  } else if (changedDistrict == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.districtSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (changedFieldArea == '') {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.areaSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {
                    //region onPress: Save Changes
                    bool isNameAltered = (savedName != changedName);
                    bool isAreaAltered = (savedFieldArea != changedFieldArea);
                    bool isDistrictAltered = (savedDistrict != changedDistrict);
                    updateRegisteredUserDetails(
                      registeredPhoneNumber,
                      userName: isNameAltered ? changedName : null,
                      area: isAreaAltered ? changedFieldArea : null,
                      district: isDistrictAltered ? changedDistrict : null,
                    );
                    updateUserDetailsSharedPreferences(
                      isNameAltered ? changedName : null,
                      isAreaAltered ? changedFieldArea : null,
                      isDistrictAltered ? changedDistrict : null,
                    );

                    showSnackBarMessage(
                      context: context,
                      backgroundColor: Color(0xFF4BB543),
                      snackBarText: AppLocalizations.of(context)
                          .translate('profile.saveChangesSnackbar'),
                    );
                    //endregion
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
