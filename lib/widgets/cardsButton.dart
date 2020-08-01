import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {

  CardButton({this.cardChild,this.onPress});

  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child:Container(
        margin: EdgeInsets.all(20),

        child: cardChild,

        decoration: kCardDecoration,
      ),
    );
  }
}