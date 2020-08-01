import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {},
            color: kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.location_on),
          ),
          IconButton(
            onPressed: () {},
            color: kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {},
            color: kInactiveIcon,
            iconSize: 25,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
