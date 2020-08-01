import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/cropDisease.dart';
import 'package:farmhelper/utilities/networking/api_helper.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DiseaseYield extends StatefulWidget {
  final String diseaseName;
  DiseaseYield({this.diseaseName});

  static const String id = 'dis';

  @override
  _DiseaseYieldState createState() => _DiseaseYieldState();
}

class _DiseaseYieldState extends State<DiseaseYield> {
  double stage = -1.0;
  int area = 50;
  List<bool> isSelected = List.filled(3, false);
  CropDisease _cropDisease;
  bool _showSpinner = false;

  void toggleSpinner() {
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

  @override
  void initState() {
    super.initState();
//    _cropDisease = CropDisease(packedCropDiseaseDetails: widget.diseaseName);
    _cropDisease = CropDisease(
        packedCropDiseaseDetails:
            'Tomato___Spider_mites Two-spotted_spider_mite');
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
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
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: kBoxfield.copyWith(
                  hintText: _cropDisease.crop,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 8.0,
              ),
              child: TextField(
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: kBoxfield.copyWith(
                  hintText: _cropDisease.disease,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 8.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Field Area Affected',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          area.toString(),
                          style: kLargeText.copyWith(color: Colors.redAccent),
                        ),
                        Text(
                          '%',
                          style: kLargeText.copyWith(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: kSliderInactiveColor,
                        activeTrackColor: kSliderActiveColor,
                        thumbColor: kSliderActiveColor,
                        overlayColor: kSliderActiveColor.withAlpha(0x29),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12.0,
                        ),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                        value: area.toDouble(),
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        onChanged: (double selectedValue) {
                          setState(() {
                            area = selectedValue.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                decoration: kCardDecoration,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 8.0,
              ),
              child: Center(
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(8.0),
                  textStyle: TextStyle(fontWeight: FontWeight.w600),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Stage 1'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Stage 2'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Stage 3'),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                    stage = index.toDouble();
                  },
                  isSelected: isSelected,
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
                    if (area == 0) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText:
                            'Please select Area greater than Zero percent',
                        backgroundColor: kSnackBarWarningColor,
                      );
                    } else if (stage < 0) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: 'Please select the Stage Type',
                        backgroundColor: kSnackBarWarningColor,
                      );
                    } else {
                      toggleSpinner();
                      double predictedYield =
                          await ApiHelper.getYieldForInfectedPlant(
                        disease: _cropDisease.diseaseCode.toString(),
                        areaAffected: (area.toDouble() / 100.0).toString(),
                        stage: stage.toString(),
                      );
                      toggleSpinner();
                      if (predictedYield != null) {
                        // Since, predictedYield is actually is Percentage
                        predictedYield *= 100;

                        Alert(
                          context: context,
                          title: 'Predicted Yield',
                          desc: predictedYield.toString(),
                          type: AlertType.success,
                          buttons: [],
                          closeFunction: () {},
                        ).show();
                      } else {
                        showSnackBarMessage(
                          context: context,
                          snackBarText:
                              'Something went wrong! Please try again',
                          backgroundColor: kSnackBarErrorColor,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
