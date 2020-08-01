import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/cardsButton.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/iconContent.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADEFD1),
      appBar: commonAppBar,
      bottomNavigationBar: NavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/default.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'Welcome, Username',
                    style: kOptionstyles,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFebedeb),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.assignment,
                              label: 'Add/View Crop Details',
                            ),
                            onPress: () {},
                          ),
                        ),
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.mail,
                              label: 'Report Crop Failure',
                            ),
                            onPress: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.system_update_alt,
                              label: 'Estimated Crop Yield',
                            ),
                            onPress: () {
                              Navigator.pushNamed(context, EstimateYield.id);
                            },
                          ),
                        ),
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.nature,
                              label: 'Check Crop for Disease',
                            ),
                            onPress: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
