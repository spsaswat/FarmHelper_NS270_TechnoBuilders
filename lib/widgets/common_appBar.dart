import 'package:flutter/material.dart';

AppBar get commonAppBar => AppBar(
      backgroundColor: Color(0xFF3CB371),
      title: Text('Farmer Helper'),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
          color: Color(0xFFC0C0C0),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle),
                  Padding(
                    child: Text('Profile'),
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
