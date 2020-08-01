import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/translator.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  final int nm;
  PhoneNumberScreen({this.nm});
  static const String id = 'phone';
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = '';
  String s1 = 'Enter your phone number';
  String s2 = 'Register';
  String phoneNumberValidation =
      'Length of Phone Number must be $kPhoneNumberLength';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int n = widget.nm;
    if (n == 1) {
      changeLanguage();
    }
  }

  void changeLanguage() async {
    String t1 = await getLanguage(s1);
    String t2 = await getLanguage(s2);
    String t3 = await getLanguage(phoneNumberValidation);
    setState(() {
      s1 = t1;
      s2 = t2;
      phoneNumberValidation = t3;
    });
  }

  Future<String> getLanguage(String k) async {
    Translator translator = Translator();
    var data = await translator.hindi(k);
    if (data == 'null') {
      return 'Loading...';
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: kBoxfield.copyWith(hintText: '$s1'),
            ),
            Builder(
              /*
                Reason for adding Builder:
                https://api.flutter.dev/flutter/material/Scaffold/of.html#material.Scaffold.of.2
              */
              builder: (context) {
                return Button(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: '$s2',
                  onPress: () {
                    if (phoneNumber.length != kPhoneNumberLength) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: phoneNumberValidation,
                        backgroundColor: Colors.redAccent,
                      );
                      return;
                    }
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
