import 'package:farmhelper/screens/phonenumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar commonAppBar(BuildContext context) => AppBar(
      backgroundColor: Color(0xFF3CB371),
      title: Text('Farmer Helper'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            FirebaseAuth auth = FirebaseAuth.instance;
            FirebaseUser user = await auth.currentUser();
            print(user.phoneNumber);
            auth.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, PhoneNumberScreen.id, (route) => false);
          },
          color: Colors.white,
        ),
      ],
    );
