import 'package:farmhelper/utilities/informationBrain.dart';
import 'package:flutter/material.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:farmhelper/widgets/nav_bar.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmhelper/widgets/round_button.dart';
import 'package:farmhelper/widgets/cropsContent.dart';
import 'package:farmhelper/screens/addDetails.dart';

InformationBrain objct = InformationBrain();

class CropDetails extends StatefulWidget {
  static const String id = 'crops';
  @override
  _CropDetailsState createState() => _CropDetailsState();
}

class _CropDetailsState extends State<CropDetails> {

  List<CropCards> cardkeeper = [];
  @override
  void initState() {

    details();
    super.initState();
  }
  void details()
  {

    int i = objct.totaldet();
    for(int j=0;j<i;j++)
      {

        cardkeeper.add(
            CropCards(
              crp: objct.getCrop(),
              f: objct.getfertilizer(),
              sesn: objct.getSeason(),
              p: objct.getPest(),
              q: objct.getQuality(),
              m: objct.getManure(),
              ar: objct.getArea(),
              stts: objct.getstatus(),
            )
        );
      }

  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar,
      bottomNavigationBar: NavBar(),
      backgroundColor: Color(0xFFebedeb),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'My Crop Details',
              style: kOptionstyles2,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cardkeeper,
          ),
          RoundButton(
           icon: FontAwesomeIcons.plus,
            onPress: (){
              Navigator.pushNamed(context, AddDetails.id);
            },
          ),

        ],
      ),
    );
  }
}


