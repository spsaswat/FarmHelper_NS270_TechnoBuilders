import 'package:farmhelper/screens/phonenumber.dart';
import 'package:flutter/material.dart';
import 'package:farmhelper/utilities/button.dart';
import 'package:farmhelper/utilities/translator.dart';
import 'package:farmhelper/screens/phonenumber.dart';

class langs extends StatefulWidget {
  static const String id = 'langs';
  @override
  _langsState createState() => _langsState();
}

class _langsState extends State<langs> {

  String hindi='Loading..';
  var f;

  @override
  void initState() {
    change();
    super.initState();

  }

  void change() async
  {
    trans objct = trans();
    var data =  await objct.hindi('Hindi');
    setState(() {
      if(data == 'null'){
        hindi = 'Loading...';
      }
      else{
        hindi = data;
      }
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            button1(clr: Colors.lightBlueAccent,ttl: 'English',onpres: (){
              //do something
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => phone(
                  nm: 0,
                ),
              ));
            },),
            button1(clr: Colors.blueAccent,ttl:hindi,onpres: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => phone(
                  nm: 1,
                ),
              ));
              //do something
            },),

        ],
        ),
      ),
    );
  }
}
