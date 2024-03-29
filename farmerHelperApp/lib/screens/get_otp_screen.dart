import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/phone_authentication.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class GetOTPScreen extends StatelessWidget {
  static const String id = 'getOTP';
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'img1',
                child: Container(
                  child: Image.asset('images/farm.png'),
                  height: 300.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
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
              ],
            ),
            Builder(
              /*
                Reason for adding Builder:
                https://api.flutter.dev/flutter/material/Scaffold/of.html#material.Scaffold.of.2
              */
              builder: (context) {
                return Button(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: AppLocalizations.of(context)
                      .translate('get_otp_screen.verify'),
                  onPress: () {
                    String otp = _codeController.text.trim();
                    if (otp.length != kOTPLength) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: AppLocalizations.of(context).translate(
                          'error.otpValidationSnackbar',
                          [kOTPLength.toString()],
                        ),
                        backgroundColor: kSnackBarWarningColor,
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
