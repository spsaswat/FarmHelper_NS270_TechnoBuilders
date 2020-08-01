import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:farmhelper/utilities/constants.dart';


class CropCards extends StatelessWidget {

  CropCards({this.crp,this.f,this.sesn,this.stts,this.p,this.m,this.q,this.ar});

  final String crp,sesn,stts,f;
  final bool p,m,q;
  final double ar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: (){
          Alert(
              context: context,
              title: "$crp",
              content: Column(
                children: <Widget>[

                  Text('Area : $ar'),
                  Text('Fertilizer: $f'),
                  Text('Season: $sesn'),
                  Text('Pesticides Used: $p'),
                  Text('Manure Used: $m'),
                  Text('Quality of Seeds: $q'),
                  Text('Current Status: $stts')

                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                DialogButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$crp',
                  style: kOptionstyles,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Season : $sesn',
                  style: kOptionstyles,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status : $stts',
                  style: kOptionstyles,
                ),
              ),

            ],
          ),
          decoration: kCardDecoration,
        ),
      ),
    );
  }
}
