import 'package:farmhelper/screens/estimationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmhelper/widgets/iconContent.dart';
import 'package:farmhelper/widgets/cardsButton.dart';
import 'package:farmhelper/utilities/constants.dart';

class Homescreen extends StatelessWidget {
  static const String id = 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADEFD1),
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
              onPressed: (){},
              color: kActiveIcon,
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
        children: <Widget>[

          Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                      image:AssetImage('images/default.jpg'),
                          fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text('Welcome, Username',style: kOptionstyles,),


                ],
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFebedeb),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
              ),

              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.assignment,
                              label: 'Add/View Crop Details',
                            ),
                            onPress: (){},
                          ),
                        ),
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.mail,
                              label: 'Report Crop Faliure',
                            ),
                            onPress: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.system_update_alt,
                              label: 'Estimated Crop Yield',
                            ),
                            onPress: (){
                              Navigator.pushNamed(context, EstimateYield.id);
                            },
                          ),
                        ),
                        Expanded(
                          child: CardButton(
                            cardChild: IconContent(
                              icon: Icons.nature,
                              label: 'Check Crop for Disease',
                            ),
                            onPress: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ),

        ],
      ),

    );
  }
}

