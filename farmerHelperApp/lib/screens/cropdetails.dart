import 'package:farmhelper/screens/addDetails.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/informationBrain.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CropDetails extends StatefulWidget {
  static const String id = 'crops';
  @override
  _CropDetailsState createState() => _CropDetailsState();
}

class _CropDetailsState extends State<CropDetails> {
  @override
  void initState() {
//    details();
    super.initState();
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
              'My Crop Details',
              style: kOptionstyles2,
              textAlign: TextAlign.center,
            ),
          ),
          cardstreamer(),
          RoundButton(
            icon: FontAwesomeIcons.plus,
            onPress: () {
              Navigator.pushNamed(context, AddDetails.id);
            },
          ),
        ],
      ),
    );
  }
}
