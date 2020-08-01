import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmhelper/utilities/button.dart';
import 'package:farmhelper/utilities/translator.dart';
import 'package:farmhelper/utilities/constants.dart';

class phone extends StatefulWidget {
  phone({this.nm});
  static const String id = 'phone';
  final int nm;
  @override
  _phoneState createState() => _phoneState(n: nm);
}

class _phoneState extends State<phone> {

  _phoneState({this.n});
  String num;
  final int n;
  String s1 = 'Enter your phone number';
  String s2 = 'Register';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(n == 1){
      change1(s1);
      change2(s2);
    }

  }
  void change1(String k) async
  {
    trans objct = trans();
    var data =  await objct.hindi(k);
    setState(() {
      if(data == 'null'){
        s1 = 'Loading...';
      }
      else{
        s1 = data;
      }
    });

  }
  void change2(String k) async
  {
    trans objct = trans();
    var data =  await objct.hindi(k);
    setState(() {
      if(data == 'null'){
        s2 = 'Loading...';
      }
      else{
        s2 = data;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                num = value;
              },
              decoration: kBoxfield.copyWith(
                  hintText: '$s1'
              ),
            ),
            button1(clr: Colors.lightBlueAccent,ttl: '$s2',
              onpres: (){
              //do something on pressing the register button
            },),
          ],
        ),
      ),
    );
  }
}
