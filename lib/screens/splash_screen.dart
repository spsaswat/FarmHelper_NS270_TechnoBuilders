import 'package:farmhelper/screens/language.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashEntryScreen extends StatelessWidget {
  static const String id = 'splash';

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      loadingText: Text("Splash"),
      navigateAfterSeconds: LanguageScreen(),
      image: Image.asset('assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}
