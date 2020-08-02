import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';


class CropCards extends StatefulWidget {
  CropCards({this.crp,this.f,this.sesn,this.p,this.m,this.q});

  final String crp,sesn,f;
  final String p,m,q;
  @override
  _CropCardsState createState() => _CropCardsState();
}

class _CropCardsState extends State<CropCards> {

  final FlutterTts flutterTts = FlutterTts();
  String _crp,_sesn,_f, _p,_m,_q;
  String lcode;
  bool spiner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _crp = "loading";
    _sesn = "loading";
    _f = "loading";
    _p = "loading";
    _m = "loading";
    _q = "loading";
    setlang();

  }
  void setlang()async
  {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    lcode = _prefs.getString('language_code');
    if(lcode == "hi")
    {

      _crp = widget.crp;
      _sesn = widget.sesn;
      _f = widget.f;
      _p = widget.p;
      _m = widget.m;
      _q = widget.q;

      final obj = GoogleTranslator();
      var trans1 = await obj.translate(_crp,to:'hi');
      var trans2 = await obj.translate(_sesn,to:'hi');
      var trans3 = await obj.translate(_f,to:'hi');
      var trans4 = await obj.translate(_p,to:'hi');
      var trans5 = await obj.translate(_m,to:'hi');
      var trans6 = await obj.translate(_q,to:'hi');
      setState(() {
        _crp =  trans1.toString();
        _sesn =  trans2.toString();
        _f =  trans3.toString();
        _p =  trans4.toString();
        _m =  trans5.toString();
        _q =  trans6.toString();
      });
    }
    if(lcode == null || lcode == "en")
    {
      setState(() {
        _crp = widget.crp;
        _sesn = widget.sesn;
        _f = widget.f;
        _p = widget.p;
        _m = widget.m;
        _q = widget.q;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    Future _speaker() async{

      if(lcode == "en" || lcode == null)
      {
        await flutterTts.setLanguage("en-IN");
        await flutterTts.speak(_crp+". Fertilizers: "+_f+". Season: "+_sesn+". Pesticides: "+_p+". Manure: "+_m+". Watering: "+_q);
      }
      else
      {
        await flutterTts.setLanguage("hi-IN");
        await flutterTts.speak(_crp+". Fertilizers: "+_f+". Season: "+_sesn+". Pesticides: "+_p+". Manure: "+_m+". Watering: "+_q);
      }

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
              title: "$_crp",
              content: Column(
                children: <Widget>[


                  Text('Fertilizers : $_f'),
                  Text('Seasons : $_sesn'),
                  Text('Pesticides : $_p'),
                  Text('Manure : $_m'),
                  Text('Watering : $_q'),


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
                  '$_crp',
                  style: kOptionstyles,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Season : $_sesn',
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