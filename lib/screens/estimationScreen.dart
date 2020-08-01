import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EstimateYield extends StatefulWidget {
  static const String id = 'estimate';
  @override
  _EstimateYieldState createState() => _EstimateYieldState();
}

class _EstimateYieldState extends State<EstimateYield> {
  String crop = kCropList[0];
  String season = kSeasons[0];
  int year = 2020;
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
      items: seasonItems,
      onChanged: (value) {
        setState(() {
          season = value;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Estimate Crop Yield',
            style: kOptionstyles,
            textAlign: TextAlign.center,
          ),
          Container(
            child: Center(
              child: cropsDropdown(),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
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
                              onpres: () {
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
                              onpres: () {
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
                    decoration: kCardDecoration,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          kMonths[start],
                          style: kLargeText,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundButton(
                              onpres: () {
                                setState(() {
                                  if (start != 0) start--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundButton(
                              onpres: () {
                                setState(() {
                                  if (start == 11)
                                    start = 0;
                                  else
                                    start++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: kCardDecoration,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Center(child: seasonDropdown()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0),
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
            child: Button(
              buttonColor: Color(0xFF53d45b),
              buttonText: 'Estimate Yield',
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
