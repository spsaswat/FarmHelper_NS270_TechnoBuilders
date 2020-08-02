import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {

  CardButton({this.cardChild,this.onPress,this.clr1,this.clr2});

  final Widget cardChild;
  final Function onPress;
  final Color clr1,clr2;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPress,
      child:Container(
        margin: EdgeInsets.all(20),

        child: cardChild,

        decoration: BoxDecoration(
          //  color: Color(0xFFb6bab7),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [clr1,clr2],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}