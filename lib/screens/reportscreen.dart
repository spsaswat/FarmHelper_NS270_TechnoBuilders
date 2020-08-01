import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/database_helper.dart'
    show reportFailure;
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  static const String id = 'report';

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String crop, area, yield, fails;

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

  DropdownButton<String> failureDropdown() {
    List<DropdownMenuItem<String>> cropItems = [];

    for (String s in kFaliures) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );
      cropItems.add(newItem);
    }

    return DropdownButton<String>(
      value: fails,
      items: cropItems,
      underline: SizedBox(),
      hint: Text("Select Reason for Damage"),
      onChanged: (value) {
        setState(() {
          fails = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      bottomNavigationBar: NavBar(),
      backgroundColor: Color(0xFFebedeb),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Report a crop failure',
              style: kOptionstyles2,
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
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                area = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Total Area Affected',
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
                yield = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Your Estimated Yield',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: failureDropdown(),
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
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Builder(
              builder: (context) => Button(
                buttonColor: Color(0xFF53d45b),
                buttonText: 'Report',
                onPress: () {
                  if (crop == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select the Crop Type',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (area == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please select area affected',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (yield == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please specify your estimated yield',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (fails == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please Specify a reason for your failure',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {
                    reportFailure(
                      area: area,
                      crop: crop,
                      fails: fails,
                      estimatedYield: yield,
                    );
                    Navigator.pop(context, 'true');
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
