import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:farmhelper/utilities/constants.dart';

class IconContent extends StatelessWidget {

  IconContent({this.icon,this.label});

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 75,
          color: Colors.white,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: kOptionstyles,
        ),
      ],
    );
  }
}
