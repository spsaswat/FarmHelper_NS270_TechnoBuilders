import 'package:farmhelper/screens/get_otp_screen.dart';
import 'package:farmhelper/screens/language.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String verificationID;

Future registerWithPhoneNumber(String mobile, int n,BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  _auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: Duration(seconds: 60),
    verificationCompleted: (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential).then((AuthResult result) {
        // TODO: Change the next screen root
        Navigator.pushReplacementNamed(context, LanguageScreen.id);
      }).catchError((e) {
        print(e);
        showSnackBarMessage(
          context: context,
          snackBarText: 'Oops! Something went wrong. Please try again.',
          backgroundColor: Colors.orangeAccent,
        );
      });
    },
    verificationFailed: (AuthException authException) {
      print(authException.message);
      showSnackBarMessage(
        context: context,
        snackBarText: 'Oops! Something went wrong. Please try again.',
        backgroundColor: Colors.orangeAccent,
      );
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      verificationID = verificationId;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetOTPScreen(lang: n,),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(verificationId);
      print("Timeout");
      showSnackBarMessage(
        context: context,
        snackBarText: 'Code retrieval timeout! Please register again.',
        backgroundColor: Colors.orangeAccent,
      );
      Navigator.pop(context);
    },
  );
}

void verifyCodeSent(String smsCode, BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthCredential _credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID, smsCode: smsCode);
  auth.signInWithCredential(_credential).then((AuthResult result) {
    // TODO: Change the next screen root
    Navigator.pushReplacementNamed(context, LanguageScreen.id);
  }).catchError((e) {
    print(e);
  });
}
