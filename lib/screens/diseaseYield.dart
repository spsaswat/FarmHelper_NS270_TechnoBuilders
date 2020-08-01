import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class DiseaseYield extends StatefulWidget {
  final String diseaseName;

  DiseaseYield({this.diseaseName});

  static const String id = 'dis';

  @override
  _DiseaseYieldState createState() => _DiseaseYieldState();
}

class _DiseaseYieldState extends State<DiseaseYield> {
  String area, stage;

  _DiseaseYieldState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADEFD1),
//      backgroundColor: Color(0xFFebedeb),
      //color: Color(0xFFebedeb),
      appBar: commonAppBar,
      bottomNavigationBar: NavBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              enabled: false,
              textAlign: TextAlign.center,
//              onChanged: (value) {
//                area = value;
//              },
              decoration: kBoxfield.copyWith(
                hintText: widget.diseaseName,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                area = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Area affected',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                stage = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Stage',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Builder(
              builder: (context) => Button(
                buttonColor: Color(0xFF53d45b),
                buttonText: 'Estimate Yield',
                onPress: () async {
                  if (stage == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select the Stage Type',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (area == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText:
                          'Please select Field Area greater than Zero',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {}
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
