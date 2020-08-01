import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashEntryScreen extends StatelessWidget {
  static const String id = 'splash';
  final String nextPageRoute;

  SplashEntryScreen({this.nextPageRoute});

  static Future<String> nextRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeUser = prefs.getBool(kFirstTimeUserSharedPrefsKey) ?? true;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    bool loggedIn = (user != null);
    if (isFirstTimeUser == false && loggedIn == false)
      return PhoneNumberScreen.id;
    else if (isFirstTimeUser == false && loggedIn == true) return HomeScreen.id;
    return LanguageScreen.id;
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      loadingText: Text("Splash"),
      navigateAfterSeconds: nextPageRoute,
      image: Image.asset('assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}
