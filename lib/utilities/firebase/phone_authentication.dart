import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';

String verificationID, mobileNumber, districtName;

Future registerWithPhoneNumber(
    String mobile, String district, BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  mobileNumber = mobile;
  districtName = district;

  _auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: Duration(seconds: 60),
    verificationCompleted: (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential).then((AuthResult result) {
        // Add User data to Database
        addRegisteredUserDetails(mobile, district);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      }).catchError((e) {
        print(e);
        showSnackBarMessage(
          context: context,
          snackBarText: AppLocalizations.of(context).translate('error.oops'),
          backgroundColor: kSnackBarErrorColor,
        );
      });
    },
    verificationFailed: (AuthException authException) {
      print(authException.message);
      showSnackBarMessage(
        context: context,
        snackBarText: AppLocalizations.of(context).translate('error.oops'),
        backgroundColor: kSnackBarErrorColor,
      );
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      verificationID = verificationId;
      Navigator.pushNamed(
        context,
        GetOTPScreen.id,
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(verificationId);
      print("Timeout");
      showSnackBarMessage(
        context: context,
        snackBarText: AppLocalizations.of(context)
            .translate('error.codeRetrievalTimeout'),
        backgroundColor: kSnackBarErrorColor,
      );
    },
  );
}

void verifyCodeSent(String smsCode, BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthCredential _credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID, smsCode: smsCode);
  auth.signInWithCredential(_credential).then((AuthResult result) {
    // Add User data to Database for users with failed code retrieval
    addRegisteredUserDetails(mobileNumber, districtName);
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
  }).catchError((e) {
    print(e);
    showSnackBarMessage(
      context: context,
      snackBarText: AppLocalizations.of(context).translate('error.oops'),
      backgroundColor: kSnackBarErrorColor,
    );
  });
}
