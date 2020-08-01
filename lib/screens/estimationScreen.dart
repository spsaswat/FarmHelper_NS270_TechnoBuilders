import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/firebase/database_helper.dart';
import 'package:farmhelper/utilities/localization/app_localizations.dart';
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
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EstimateYield extends StatefulWidget {
  static const String id = 'estimate';
  @override
  _EstimateYieldState createState() => _EstimateYieldState();
}

class _EstimateYieldState extends State<EstimateYield> {
  String crop, season, district, area;
  int year = DateTime.now().year;
  bool showSpinner = false;

  void toggleSpinner() {
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  //region cropsDropdown
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
  //endregion

  //region seasonDropdown
  DropdownButton<String> seasonDropdown() {
    List<DropdownMenuItem<String>> seasonItems = [];

    for (String s in kSeasons) {
      var newItem = DropdownMenuItem(
        child: Text(AppLocalizations.of(context).translate('kSeasons.' + s)),
        value: s,
      );
      seasonItems.add(newItem);
    }

    return DropdownButton<String>(
      value: season,
      hint: Text(AppLocalizations.of(context).translate('kSeasons.default')),
      underline: SizedBox(),
      items: seasonItems,
      onChanged: (value) {
        setState(() {
          season = value;
        });
      },
    );
  }
  //endregion

  //region districtsDropdown
  DropdownButton<String> districtsDropdown() {
    List<DropdownMenuItem<String>> districtsItems = [];

    for (String s in kDistricts) {
      var newItem = DropdownMenuItem(
        child: Text(AppLocalizations.of(context).translate('kDistricts.' + s)),
        value: s,
      );
      districtsItems.add(newItem);
    }

    return DropdownButton<String>(
      value: district,
      hint: Text(AppLocalizations.of(context).translate('kDistricts.default')),
      underline: SizedBox(),
      items: districtsItems,
      onChanged: (value) {
        setState(() {
          district = value;
        });
      },
    );
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADEFD1),
//      backgroundColor: Color(0xFFebedeb),
      //color: Color(0xFFebedeb),
      appBar: commonAppBar(context),
      bottomNavigationBar: NavBar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)
                    .translate('estimationScreen.title'),
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
                        AppLocalizations.of(context)
                            .translate('estimationScreen.year'),
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
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Builder(
                builder: (context) => Button(
                  buttonColor: Color(0xFF53d45b),
                  buttonText: AppLocalizations.of(context)
                      .translate('estimationScreen.estimate'),
                  onPress: () async {
                    if (crop == null) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: AppLocalizations.of(context)
                            .translate('error.cropSnackbar'),
                        backgroundColor: kSnackBarWarningColor,
                      );
                    } else if (district == null) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: AppLocalizations.of(context)
                            .translate('error.districtSnackbar'),
                        backgroundColor: kSnackBarWarningColor,
                      );
                    } else if (season == null) {
                      showSnackBarMessage(
                        context: context,
                        snackBarText: AppLocalizations.of(context)
                            .translate('error.seasonSnackbar'),
                        backgroundColor: kSnackBarWarningColor,
                      );
                    } else {
                      toggleSpinner();
                      double predictedYield =
                          await ApiHelper.getYieldPrediction(
                              crop, district, year.toString(), season, '1000');
                      toggleSpinner();
                      if (predictedYield != null) {
                        addYieldPredictedWithoutDisease(
                          crop,
                          district,
                          year.toString(),
                          season,
                          '1000',
                          predictedYield.toString(),
                        );
                        Alert(
                          context: context,
                          title: AppLocalizations.of(context)
                              .translate('estimationScreen.yield.alert.title'),
                          desc: AppLocalizations.of(context).translate(
                              'estimationScreen.yield.alert.desc',
                              [predictedYield.toStringAsFixed(2)]),
                          type: AlertType.success,
                          buttons: [],
                          closeFunction: () {},
                        ).show();
                      } else {
                        showSnackBarMessage(
                          context: context,
                          snackBarText: AppLocalizations.of(context)
                              .translate('error.oops'),
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
