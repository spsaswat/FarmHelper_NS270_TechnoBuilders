import 'package:farmhelper/screens/get_otp_screen.dart';
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
      initialRoute: LanguageScreen.id,
      routes: {
        LanguageScreen.id: (context) => LanguageScreen(),
        PhoneNumberScreen.id: (context) => PhoneNumberScreen(),
        GetOTPScreen.id: (context) => GetOTPScreen(),
      },
    );
  }
}

//void main() => runApp(FlashChat());
//
//class FlashChat extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//
//      initialRoute: WelcomeScreen.id,
//      routes: {
//        WelcomeScreen.id: (context) => WelcomeScreen(),
//        LoginScreen.id: (context) => LoginScreen(),
//        RegistrationScreen.id: (context) => RegistrationScreen(),
//        ChatScreen.id: (context) => ChatScreen(),
//      },
//    );
//  }
//}
