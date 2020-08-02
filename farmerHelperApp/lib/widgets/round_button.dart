import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.onPress, this.icon});

  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 5,
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPress,
      constraints: BoxConstraints.tightFor(width: 46, height: 46),
      shape: CircleBorder(),
      fillColor: Color(0xFFa3a3a3),
    );
  }
}
