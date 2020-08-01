import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';

String verificationID, mobileNumber, districtName;

Future registerWithPhoneNumber(
    String mobile, String district, int n, BuildContext context) async {
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
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }).catchError((e) {
        print(e);
        showSnackBarMessage(
          context: context,
          snackBarText: 'Oops! Something went wrong. Please try again.',
          backgroundColor: kSnackBarErrorColor,
        );
      });
    },
    verificationFailed: (AuthException authException) {
      print(authException.message);
      showSnackBarMessage(
        context: context,
        snackBarText: 'Oops! Something went wrong. Please try again.',
        backgroundColor: kSnackBarErrorColor,
      );
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      verificationID = verificationId;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetOTPScreen(
            lang: n,
          ),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(verificationId);
      print("Timeout");
      showSnackBarMessage(
        context: context,
        snackBarText: 'Code retrieval timeout! Please register again.',
        backgroundColor: kSnackBarErrorColor,
      );
    },
  );
}

void verifyCodeSent(String smsCode, BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Add User data to Database for users with failed code retrieval
  addRegisteredUserDetails(mobileNumber, districtName);
  AuthCredential _credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID, smsCode: smsCode);
  auth.signInWithCredential(_credential).then((AuthResult result) {
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }).catchError((e) {
    print(e);
  });
}
