import 'dart:io' show File;

import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/database_helper.dart'
    show reportFailure;
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  static const String id = 'report';
  ReportScreen({this.lat, this.lon, this.imageFiles});
  final List<double> lat;
  final List<double> lon;
  final List<File> imageFiles;
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String crop, area, yield, fails;

  DropdownButton<String> cropsDropdown() {
    List<DropdownMenuItem<String>> cropItems = [];

    for (String s in kCropList) {
      var newItem = DropdownMenuItem(
        child: Text(AppLocalizations.of(context).translate('kCrops.' + s)),
        value: s,
      );
      cropItems.add(newItem);
    }

    return DropdownButton<String>(
      value: crop,
      items: cropItems,
      underline: SizedBox(),
      hint: Text(AppLocalizations.of(context).translate('kCrops.default')),
      onChanged: (value) {
        setState(() {
          crop = value;
        });
      },
    );
  }

  DropdownButton<String> failureDropdown() {
    List<DropdownMenuItem<String>> cropItems = [];

    for (String s in kFailureReasons) {
      var newItem = DropdownMenuItem(
        child: Text(
            AppLocalizations.of(context).translate('kFailureReasons.' + s)),
        value: s,
      );
      cropItems.add(newItem);
    }

    return DropdownButton<String>(
      value: fails,
      items: cropItems,
      underline: SizedBox(),
      hint: Text(
          AppLocalizations.of(context).translate('kFailureReasons.default')),
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
              AppLocalizations.of(context).translate('report.title'),
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
                hintText: AppLocalizations.of(context)
                    .translate('report.areaSliderTitle'),
                suffixText:
                    AppLocalizations.of(context).translate('report.areaUnits'),
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
                hintText:
                    AppLocalizations.of(context).translate('report.yield'),
                suffixText:
                    AppLocalizations.of(context).translate('report.yieldUnits'),
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
                buttonText:
                    AppLocalizations.of(context).translate('report.btnReport'),
                onPress: () {
                  if (crop == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.cropSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (area == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.areaAffectedSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (yield == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.yieldSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else if (fails == null) {
                    showSnackBarMessage(
                      context: context,
                      snackBarText: AppLocalizations.of(context)
                          .translate('error.failureReasonSnackbar'),
                      backgroundColor: kSnackBarWarningColor,
                    );
                  } else {
                    reportFailure(
                      area: area,
                      crop: crop,
                      fails: fails,
                      givenYield: yield,
                      latitudes: widget.lat,
                      longitudes: widget.lon,
                    );
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
