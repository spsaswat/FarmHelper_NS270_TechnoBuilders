import 'dart:convert' show base64Url;
import 'dart:io' show File;
import 'dart:math' show Random;

import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/database_helper.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  String crop, area, givenYield, fails;
  bool showSpinner = false;
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: kFirebaseStorageBucket);
  List<StorageUploadTask> _uploadTask;
  List<String> imageFileNames;
  int imageNumber = 0, totalImages;
  double progressPercent = 0;

  @override
  void initState() {
    super.initState();
    //region Generate Random File Name for images
    imageFileNames = List(widget.imageFiles.length);
    for (int i = 0; i < imageFileNames.length; i++)
      imageFileNames[i] = base64Url.encode(
        List<int>.generate(
          16,
          (k) => Random.secure().nextInt(256),
        ),
      );
    //endregion
    _uploadTask = List<StorageUploadTask>(widget.imageFiles.length);
    totalImages = _uploadTask.length;
  }

  //region addImagesToFirebaseStorage
  Future<void> addImagesToFirebaseStorage() async {
    /*
    The reason behind keeping this function here, instead of in database_helper.dart
    is that a visual representation of the uploading process is required.
    That can be easily achieved by keeping the said function in UI section.
     */
    for (int i = 0; i < _uploadTask.length; i++) {
      String filePath = '/failure_images/${imageFileNames[i]}.png';
      setState(() {
        _uploadTask[i] =
            _storage.ref().child(filePath).putFile(widget.imageFiles[i]);
      });
      imageFileNames[i] =
          await (await _uploadTask[i].onComplete).ref.getDownloadURL();
      setState(() {
        imageNumber++;
        progressPercent = imageNumber / totalImages;
      });
    }
  }
  //endregion

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

  void toggleSpinner() {
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    if (progressPercent != 1)
                      Text(
                          'Uploading image ${imageNumber + 1} of $totalImages...'),
                    if (progressPercent == 1)
                      Text("Uploaded $totalImages images!"),
                    // Progress bar
                    LinearProgressIndicator(value: progressPercent),
                  ],
                ),
              ),
              Text('Uploaded ${(progressPercent * 100).toStringAsFixed(2)} % '),
              AlertDialog(
                title: Text(
                  AppLocalizations.of(context)
                      .translate('homescreen.reportFailure.alert.title'),
                ),
                content: Text(
                  AppLocalizations.of(context)
                      .translate('homescreen.reportFailure.alert.desc'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
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
                  suffixText: AppLocalizations.of(context)
                      .translate('report.areaUnits'),
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
                  givenYield = value;
                },
                decoration: kBoxfield.copyWith(
                  hintText:
                      AppLocalizations.of(context).translate('report.yield'),
                  suffixText: AppLocalizations.of(context)
                      .translate('report.yieldUnits'),
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
                  buttonText: AppLocalizations.of(context)
                      .translate('report.btnReport'),
                  onPress: () async {
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
                    } else if (givenYield == null) {
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
                      toggleSpinner();
                      await addImagesToFirebaseStorage();
                      reportFailure(
                        area: area,
                        crop: crop,
                        fails: fails,
                        givenYield: givenYield,
                        latitudes: widget.lat,
                        longitudes: widget.lon,
                        imageFileNames: imageFileNames,
                      );
                      toggleSpinner();
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
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
