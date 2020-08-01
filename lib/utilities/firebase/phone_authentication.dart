import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String verificationID;

Future registerWithPhoneNumber(String mobile, BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  _auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: Duration(seconds: 60),
    verificationCompleted: (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential).then((AuthResult result) {
        Navigator.pushReplacementNamed(context, LanguageScreen.id);
      }).catchError((e) {
        print(e);
      });
    },
    verificationFailed: (AuthException authException) {
      print(authException.message);
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      verificationID = verificationId;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetOTPScreen(),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(verificationId);
      print("Timeout");
    },
  );
}

void verifyCodeSent(String smsCode, BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthCredential _credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID, smsCode: smsCode);
  auth.signInWithCredential(_credential).then((AuthResult result) {
    Navigator.pushReplacementNamed(context, LanguageScreen.id);
  }).catchError((e) {
    print(e);
  });
}
