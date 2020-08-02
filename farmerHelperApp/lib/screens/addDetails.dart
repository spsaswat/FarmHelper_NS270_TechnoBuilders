import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';

final _firestore = Firestore.instance;

class AddDetails extends StatefulWidget {
  static const String id = 'addDetail';
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  String crop, area, fertilizer, season, p, m, q, sttus;

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

  DropdownButton<String> statusDropdown() {
    List<DropdownMenuItem<String>> seasonItems = [];

    for (String s in kCropStatus) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );
      seasonItems.add(newItem);
    }

    return DropdownButton<String>(
      value: sttus,
      hint: Text("Select Current Status"),
      underline: SizedBox(),
      items: seasonItems,
      onChanged: (value) {
        setState(() {
          sttus = value;
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
              'Add crop',
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
                hintText: 'Total Area in acres',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                fertilizer = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Fertilizer Used',
              ),
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
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                p = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Yes/No Pesticides Used',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                m = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Yes/NO Manure Used',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              onChanged: (value) {
                q = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Quality of Seeds',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 8.0,
            ),
            child: Container(
              child: statusDropdown(),
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
                buttonText: 'Add Crop',
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
                  } else if (p == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please specify your estimated yield',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (m == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: 'Please Specify a reason for your faliure',
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {
                    //crop,area,fertilizer,season,p,m,q,sttus;
                    _firestore.collection('cropdetail').add({
                      'Area': area,
                      'Crop': crop,
                      'Fertilizers': fertilizer,
                      'Manure': m,
                      'Pesticides': p,
                      'Quality': q,
                      'Season': season,
                      'Status': sttus,
                    });
                    print('Working');
                    Navigator.popUntil(
                        context, ModalRoute.withName(HomeScreen.id));
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
