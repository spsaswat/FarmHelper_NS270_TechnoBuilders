/* This Dart file is the main entry point for the FarmerHelperApp, a Flutter application designed to assist farmers with various features such as chatting, 
managing crop details, detecting diseases, estimating yields, and more. The app includes a splash screen that leads to other functional screens based on user 
interaction. It supports localization to cater to a diverse user base, allowing for language selection and adapting to the user's preferred language. The app 
initializes with necessary setups like fetching the user's locale and determining the initial route based on certain conditions. It uses the Provider package 
for state management, particularly to manage app-wide language settings, and defines routes for navigation between different screens of the app. Localization 
support is implemented to provide translations and support for multiple languages, ensuring the app is accessible to users worldwide.*/

import 'package:farmhelper/screens/ChatScreen.dart';
import 'package:farmhelper/screens/addDetails.dart';
import 'package:farmhelper/screens/cropdetails.dart';
import 'package:farmhelper/screens/diseaseYield.dart';
import 'package:farmhelper/screens/disease_detection_screen.dart';
import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/screens/imageCollector.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/screens/profile_screen.dart';
import 'package:farmhelper/screens/reportscreen.dart';
import 'package:farmhelper/screens/splash_screen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/localization/app_language.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  String initialRoute = await SplashEntryScreen.nextRoute();
  runApp(MyApp(
    appLanguage: appLanguage,
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final String initialRoute;

  MyApp({this.appLanguage, this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>.value(
      value: appLanguage,
      child: Consumer<AppLanguage>(
        builder: (context, value, child) {
          return MaterialApp(
            locale: value.appLocal,
            home: SplashEntryScreen(
              nextPageRoute: initialRoute,
            ),
            routes: {
              SplashEntryScreen.id: (context) => SplashEntryScreen(),
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
              DiseaseYield.id: (context) => DiseaseYield(),
              ProfileScreen.id: (context) => ProfileScreen(),
              ImageCollect.id: (context) => ImageCollect(),
            },
            // List all of the app's supported locales here
            supportedLocales: [
              for (String languageCode in kSupportedLanguages)
                Locale(languageCode, '')
            ],
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
