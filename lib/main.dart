import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:farmhelper/screens/phonenumber.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Homescreen.id,
      routes: {
        LanguageScreen.id: (context) => LanguageScreen(),
        PhoneNumberScreen.id: (context) => PhoneNumberScreen(),
        GetOTPScreen.id: (context) => GetOTPScreen(),
        Homescreen.id: (context) => Homescreen(),
        EstimateYield.id: (context) => EstimateYield(),
      },
    );
  }
}

