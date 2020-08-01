import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:farmhelper/utilities/constants.dart';


class CropCards extends StatelessWidget {

  CropCards({this.crp,this.f,this.sesn,this.p,this.m,this.q});

  final String crp,sesn,f;
  final String p,m,q;
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {

    Future _speaker() async{
      await flutterTts.setLanguage("en-IN");
      await flutterTts.speak(crp+". Fertilizers: "+f+". Season: "+sesn+". Pesticides: "+p+". Manure: "+m+". Watering: "+q);
    }

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


                  Text('Fertilizers : $f'),
                  Text('Seasons : $sesn'),
                  Text('Pesticides : $p'),
                  Text('Manure : $m'),
                  Text('Watering : $q'),


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
                  onPressed: (){
                    _speaker();
                  },
                  child: Text(
                    "Listen",
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



            ],
          ),
          decoration: kCardDecoration,
        ),
      ),
    );
  }
}
