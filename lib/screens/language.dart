import 'package:farmhelper/screens/phonenumber.dart';
import 'package:farmhelper/utilities/translator.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LanguageScreen extends StatefulWidget {
  static const String id = 'language';
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String hindi = 'Loading..';
  bool spinner = false;
  var f;

  @override
  void initState() {

    change();

    super.initState();
  }

  void change() async {
    setState(() {
      spinner = true;

    });
    Translator objct = Translator();
    var data = await objct.hindi('Hindi');
    setState(() {

      if (data == 'null') {

        hindi = 'Loading...';

      } else {
        hindi = data;
        spinner=false;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0FFFF),
      body: ModalProgressHUD(
        inAsyncCall: spinner,

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'img1',
                    child: Container(
                      child: Image.asset('images/farm.png'),
                      height: 60.0,
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: ScaleAnimatedTextKit(

                      repeatForever: true,
                      text: [
                        "FARMER",
                        "HELPER",
                      ],
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
//                          fontFamily: "Canterbury"
                      ),
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
