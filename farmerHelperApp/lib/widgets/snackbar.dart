import 'package:flutter/material.dart';

void showSnackBarMessage(
    {BuildContext context, String snackBarText, Color backgroundColor}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(snackBarText),
    backgroundColor: backgroundColor,
    elevation: 10.0,
  ));
}
