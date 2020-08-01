import 'package:flutter/material.dart';

AppBar get commonAppBar => AppBar(
      backgroundColor: Color(0xFF3CB371),
      title: Text('Farmer Helper'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){},
          color: Colors.white,
        ),
      ],
    );
