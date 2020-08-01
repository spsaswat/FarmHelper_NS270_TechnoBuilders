import 'package:flutter/material.dart';


class button1 extends StatelessWidget {

  button1({this.clr,this.ttl,this.onpres});

  final Color clr;
  final String ttl;
  final Function onpres;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: clr,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpres,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            ttl,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
