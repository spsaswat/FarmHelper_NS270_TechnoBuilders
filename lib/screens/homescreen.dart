import 'package:farmhelper/screens/cropdetails.dart';
import 'package:farmhelper/screens/disease_detection_screen.dart';
import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:farmhelper/screens/reportscreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/widgets/cardsButton.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/iconContent.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation1, animation2, a3, a4, a5, a6, a7, a8;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
//      upperBound: 60.0,   Color(0xffc4f5dc),Color(0xffffffff),Color(0xffd5e0db)
//      clr1: Color(0xccffe259),
//      clr2: Color(0xffffa751),
    );
//    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation1 = ColorTween(begin: Color(0xffffa751), end: Color(0xccffe259))
        .animate(controller);
    animation2 = ColorTween(begin: Color(0xccffe259), end: Color(0xffffa751))
        .animate(controller);

    a3 = ColorTween(begin: Color(0xcc91eae4), end: Color(0xcc7f7fd5))
        .animate(controller);
    a4 = ColorTween(begin: Color(0xcc7f7fd5), end: Color(0xcc91eae4))
        .animate(controller);

    a5 = ColorTween(begin: Color(0xff78ffd6), end: Color(0xffa8ff78))
        .animate(controller);
    a6 = ColorTween(begin: Color(0xffa8ff78), end: Color(0xff78ffd6))
        .animate(controller);

    a7 = ColorTween(begin: Color(0xccff9472), end: Color(0xccf2789c))
        .animate(controller);
    a8 = ColorTween(begin: Color(0xccf2789c), end: Color(0xccff9472))
        .animate(controller);

    controller.forward();

//    animation.addStatusListener((status) {
//      if(status == AnimationStatus.completed){
//        controller.reverse(from: 1.0);
//      }
//      else if(status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [Color(0xff1d976c), Color(0xff93f9a9)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
//                color: Color(0xFFebedeb),
//                  color: Color(0xFFFFFFFF),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffc4f5dc),
                      Color(0xffffffff),
                      Color(0xffd5e0db)
                    ],
                  ),
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
                              clr1: animation1.value,
                              clr2: animation2.value,
                              onPress: () {
                                Navigator.pushNamed(context, CropDetails.id);
                              },
                            ),
                          ),
                          Expanded(
                            child: CardButton(
                              cardChild: IconContent(
                                icon: Icons.mail,
                                label: 'Report Crop Failure',
                              ),
                              clr1: a3.value,
                              clr2: a4.value,
                              onPress: () async {
                                Alert(
                                  closeFunction: () {},
                                  buttons: [],
                                  context: context,
                                  title: 'Need Assistance ?',
                                  desc:
                                      "Click on the call button in the bottom to avail any support immediately.",
                                ).show();
                                final reportAdded = await Navigator.pushNamed(
                                    context, ReportScreen.id);
                                if (reportAdded != null) {
                                  Alert(
                                    context: context,
                                    title: 'Reported Failure',
                                    desc:
                                        "Your report has been noted will reach you soon",
                                    type: AlertType.success,
                                    buttons: [],
                                    closeFunction: () {},
                                  ).show();
                                }
                              },
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
                              clr1: a5.value,
                              clr2: a6.value,
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
                              clr1: a7.value,
                              clr2: a8.value,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, DiseaseDetectionScreen.id);
                              },
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
      ),
    );
  }
}
