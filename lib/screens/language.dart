import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/localization/app_language.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  static const String id = 'language';
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'img1',
                  child: Container(
                    child: Image.asset('images/farm.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: ScaleAnimatedTextKit(
                    repeatForever: true,
                    text: [
                      "FARMER",
                      "HELPER",
                    ],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
//                          fontFamily: "Canterbury"
                    ),
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topStart,
                  ),
                ),
              ],
            ),
            Button(
              buttonColor: Colors.lightBlueAccent,
              buttonText: 'English',
              onPress: () async {
                appLanguage.changeLanguage(Locale('en'));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(kFirstTimeUserSharedPrefsKey, false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(),
                    ));
              },
            ),
            Button(
              buttonColor: Colors.blueAccent,
              buttonText: 'हिन्दी',
              onPress: () async {
                appLanguage.changeLanguage(Locale('hi'));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(kFirstTimeUserSharedPrefsKey, false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
