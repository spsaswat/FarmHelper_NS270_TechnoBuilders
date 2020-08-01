import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/phone_authentication.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class GetOTPScreen extends StatelessWidget {
  static const String id = 'getOTP';
  final _codeController = TextEditingController();
  final String _otpValidation = 'The length of the OTP must be $kOTPLength';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              widthFactor: 2.0,
              child: PinCodeTextField(
                maxLength: kOTPLength,
                controller: _codeController,
                pinBoxHeight: kPinBoxSide,
                pinBoxWidth: kPinBoxSide,
                pinBoxRadius: kPinBoxSide / 2,
                keyboardType: TextInputType.number,
                autofocus: true,
                highlight: true,
                highlightColor: Colors.green,
                defaultBorderColor: Colors.black54,
                hasTextBorderColor: Colors.lightBlueAccent,
              ),
            ),
            Builder(
              /*
                Reason for adding Builder:
                https://api.flutter.dev/flutter/material/Scaffold/of.html#material.Scaffold.of.2
              */
              builder: (context) {
                return Button(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Verify',
                  onPress: () {
                    String otp = _codeController.text.trim();
                    if (otp.length != kOTPLength) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: _otpValidation,
                        backgroundColor: Colors.redAccent,
                      );
                      return;
                    }
                    verifyCodeSent(otp, context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}