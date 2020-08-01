import 'package:farmhelper/screens/ChatScreen.dart';
import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/screens/profile_screen.dart';
import 'package:farmhelper/screens/reportscreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  NavBar();

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context).settings.name ?? 'null';
    return BottomAppBar(
      color: Color(0xFFf2f2f2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
            },
            color: currentRoute == HomeScreen.id ? kActiveIcon : kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ProfileScreen.id,
                ModalRoute.withName(HomeScreen.id),
              );
            },
            color:
                currentRoute == ProfileScreen.id ? kActiveIcon : kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ChatScreen.id);
            },
            color: kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.headset_mic),
          ),
          IconButton(
            onPressed: () {
              launch("tel://7003814954");
            },
            color:
                currentRoute == ReportScreen.id ? kActiveIcon : kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.phone),
          ),
        ],
      ),
    );
  }
}
