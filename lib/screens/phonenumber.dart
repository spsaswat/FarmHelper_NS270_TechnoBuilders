import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/phone_authentication.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  static const String id = 'phone';
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = '', district;

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
    AppLocalizations _appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'img1',
                child: Container(
                  child: Image.asset('images/farm.png'),
                  height: 300.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 8.0,
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                autofocus: true,
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: kBoxfield.copyWith(
                  hintText: _appLocalizations
                      .translate('phonenumber.phoneNumberHint'),
                  prefixText: kCountryCode,
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
            Builder(
              /*
                Reason for adding Builder:
                https://api.flutter.dev/flutter/material/Scaffold/of.html#material.Scaffold.of.2
              */
              builder: (context) {
                return Button(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText:
                      _appLocalizations.translate('phonenumber.register'),
                  onPress: () {
                    if (phoneNumber.length != kPhoneNumberLength) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: _appLocalizations.translate(
                            'error.phoneValidationSnackbar',
                            [kPhoneNumberLength.toString()]),
                        backgroundColor: Colors.redAccent,
                      );
                      return;
                    } else if (district == null) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: _appLocalizations
                            .translate('error.districtSnackbar'),
                        backgroundColor: kSnackBarWarningColor,
                      );
                      return;
                    }
                    registerWithPhoneNumber(
                        kCountryCode + phoneNumber, district, context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
