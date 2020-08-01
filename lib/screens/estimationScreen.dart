import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/networking/api_helper.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/round_button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EstimateYield extends StatefulWidget {
  static const String id = 'estimate';
  @override
  _EstimateYieldState createState() => _EstimateYieldState();
}

class _EstimateYieldState extends State<EstimateYield> {
  String crop, season, district;
  int year = DateTime.now().year;
  int start = 0;
  String area;

  DropdownButton<String> cropsDropdown() {
    List<DropdownMenuItem<String>> cropItems = [];

    for (String s in kCropList) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );
      cropItems.add(newItem);
    }

    return DropdownButton<String>(
      value: crop,
      items: cropItems,
      underline: SizedBox(),
      hint: Text("Select Crop Type"),
      onChanged: (value) {
        setState(() {
          crop = value;
        });
      },
    );
  }

  DropdownButton<String> seasonDropdown() {
    List<DropdownMenuItem<String>> seasonItems = [];

    for (String s in kSeasons) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );
      seasonItems.add(newItem);
    }

    return DropdownButton<String>(
      value: season,
      hint: Text("Select Season"),
      underline: SizedBox(),
      items: seasonItems,
      onChanged: (value) {
        setState(() {
          season = value;
        });
      },
    );
  }

  DropdownButton<String> districtsDropdown() {
    List<DropdownMenuItem<String>> districtsItems = [];

    for (String s in kDistricts) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );
      districtsItems.add(newItem);
    }

    return DropdownButton<String>(
      value: district,
      hint: Text("Select your District"),
      underline: SizedBox(),
      items: districtsItems,
      onChanged: (value) {
        setState(() {
          district = value;
        });
      },
    );
  }

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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Estimate Crop Yield',
              style: kOptionstyles,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: cropsDropdown(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                ),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: districtsDropdown(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                ),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 8.0,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Year',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          year.toString(),
                          style: kLargeText,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundButton(
                              onPress: () {
                                setState(() {
                                  year--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundButton(
                              onPress: () {
                                setState(() {
                                  year++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: kCardDecoration,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: seasonDropdown(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                ),
                borderRadius: BorderRadius.circular(32.0),
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
                hintText: 'Enter Field Area',
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
                  if (crop == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select the Crop Type',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (district == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select your District',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (season == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select the Season',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (area == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText:
                          'Please select Field Area greater than Zero',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {
                    double predictedYield = await ApiHelper()
                        .getYieldPrediction(
                            crop, district, year.toString(), season, area);
                    Alert(
                      context: context,
                      title: 'Predicted Yield',
                      desc: predictedYield.toString(),
                      type: AlertType.success,
                      buttons: [],
                      closeFunction: () {},
                    ).show();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
