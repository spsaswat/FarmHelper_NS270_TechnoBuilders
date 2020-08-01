import 'package:farmhelper/widgets/cropsContent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;
class cardstreamer extends StatelessWidget {
  const cardstreamer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cropdetail').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final details = snapshot.data.documents;
        List<CropCards> cardkeeper = [];
        for(var detl in details){
//          final area = detl.data['Area'];
          final crp = detl.data['Crop'];
          final Fertilizers = detl.data['Fertilizers'];
          final Manure = detl.data['Manure'];
          final Pesticides = detl.data['Pesticides'];
          final Quality = detl.data['Quality'];
          final Season = detl.data['Season'];
//          final Status = detl.data['Status'];
//                print(crp);
          final wiget =CropCards(
            crp: crp,
            f: Fertilizers,
            sesn: Season,
            p: Pesticides,
            q: Quality,
            m: Manure,

          );

          cardkeeper.add(wiget);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cardkeeper,
        );


      },
    );
  }
}


