import 'package:farmhelper/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmhelper/widgets/roundbutton.dart';

class EstimateYield extends StatefulWidget {
  static const String id = 'Estimate';
  @override
  _EstimateYieldState createState() => _EstimateYieldState();
}

class _EstimateYieldState extends State<EstimateYield> {

  String crop = 'wheat';
  String sesn = 'Summer';
  int year = 2020;
  int start = 0;
  String area ;

  DropdownButton<String> dropdown() {
    List<DropdownMenuItem<String>> cropitems = [];

    for (String s in cropList) {
      var newItem = DropdownMenuItem(

        child: Text(s),
        value: s,
      );
      cropitems.add(newItem);
    }

    return DropdownButton<String>(
      value: crop,
      items: cropitems,
      onChanged: (value) {
        setState(() {
          crop = value;
        });
      },
    );
  }

  DropdownButton<String> seasondropdown(){

    List<DropdownMenuItem<String>> seasonitems = [];

    for (String s in season){
      var newItem = DropdownMenuItem(

        child: Text(s),
        value: s,
      );
      seasonitems.add(newItem);
    }

    return DropdownButton<String>(
      value: sesn,
      items: seasonitems,
      onChanged: (value){
      setState(() {
        sesn = value;
      });
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADEFD1),
//      backgroundColor: Color(0xFFebedeb),
      //color: Color(0xFFebedeb),
      appBar: AppBar(
        backgroundColor: Color(0xFF3CB371),
        title: Text('Farmer Helper'),
        centerTitle: true,

        actions: <Widget>[
          PopupMenuButton(
            color:Color(0xFFC0C0C0),
            itemBuilder: (context) =>[
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_circle),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          )
        ],

      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFf2f2f2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              color: kInactiveIcon,
              iconSize: 25,
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: (){},
              color: kInactiveIcon,
              iconSize:25,
              icon: Icon(Icons.location_on),
            ),
            IconButton(
              onPressed: (){},
              color: kInactiveIcon,
              iconSize: 25,
              icon: Icon(Icons.chat),
            ),
            IconButton(
              onPressed: (){},
              color: kInactiveIcon,
              iconSize: 25,
              icon: Icon(Icons.settings),
            ),

          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Estimate Crop Yield', style: kOptionstyles,textAlign: TextAlign.center,),
          Container(
            child: Center(child: dropdown()),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(year.toString(),style: kLargeText,textAlign: TextAlign.center,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            RoundButton(
                              onpres: (){
                                setState(() {
                                  year--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundButton(
                              onpres: (){
                                setState(() {
                                  year++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),

                          ],
                        ),
                      ],
                    ),
                    decoration: kCardDecoration,

                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(months[start],style: kLargeText,textAlign: TextAlign.center,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            RoundButton(
                              onpres: (){
                                setState(() {
                                  if(start != 0)
                                  start--;
                                });
                              },
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundButton(
                              onpres: (){
                                setState(() {
                                  if(start == 11)
                                    start = 0;
                                  else
                                    start++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),

                          ],
                        ),
                      ],
                    ),
                    decoration: kCardDecoration,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Center(child: seasondropdown()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,right: 35.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                area = value;
              },
              decoration: kBoxfield.copyWith(
                hintText: 'Enter Field Area',

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35,right: 35),
            child: Button(
              buttonColor: Color(0xFF53d45b),
              buttonText: 'Estimate Yield',
              onPress: (){},
            ),
          ),
        ],
      ),
    );
  }
}


