import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/utilities/translator.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  static const String id = 'language';
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String hindi = 'Loading..';
  var f;

  @override
  void initState() {
    change();
    super.initState();
  }

  void change() async {
    Translator objct = Translator();
    var data = await objct.hindi('Hindi');
    setState(() {
      if (data == 'null') {
        hindi = 'Loading...';
      } else {
        hindi = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Button(
              buttonColor: Colors.lightBlueAccent,
              buttonText: 'English',
              onPress: () {
                //do something
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(
                        nm: 0,
                      ),
                    ));
              },
            ),
            Button(
              buttonColor: Colors.blueAccent,
              buttonText: hindi,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(
                        nm: 1,
                      ),
                    ));
                //do something
              },
            ),
          ],
        ),
      ),
    );
  }
}
