import 'package:farmhelper/screens/ChatScreen.dart';
import 'package:farmhelper/screens/addDetails.dart';
import 'package:farmhelper/screens/cropdetails.dart';
import 'package:farmhelper/screens/diseaseYield.dart';
import 'package:farmhelper/screens/disease_detection_screen.dart';
import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/screens/reportscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        LanguageScreen.id: (context) => LanguageScreen(),
        PhoneNumberScreen.id: (context) => PhoneNumberScreen(),
        GetOTPScreen.id: (context) => GetOTPScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EstimateYield.id: (context) => EstimateYield(),
        ReportScreen.id: (context) => ReportScreen(),
        CropDetails.id: (context) => CropDetails(),
        AddDetails.id: (context) => AddDetails(),
        ChatScreen.id: (context) => ChatScreen(),
        DiseaseDetectionScreen.id: (context) => DiseaseDetectionScreen(),
        DiseaseYield.id: (context) => DiseaseYield()
      },
    );
  }
}
