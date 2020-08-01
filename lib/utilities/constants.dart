import 'package:flutter/material.dart';

// Data
const int kPhoneNumberLength = 10;
const int kOTPLength = 6;
const String kCountryCode = '+91';

// UI
const double kPinBoxSide = 45.0;

const kBoxfield = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kOptionstyles = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kCardDecoration =  BoxDecoration(
  color: Color(0xFFb6bab7),
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);


const kLargeText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: Colors.white,
);


const kActiveIcon = Color(0xFF6eeb60);
const kInactiveIcon = Color(0xFFb0b0b0);


const List<String> cropList = [
  'wheat',
  'rice',
  'barley',
  'banana'
];

const List<String> months = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JUL',
  'AUG',
  'SEP',
  'OCT',
  'NOV',
  'DEC'
];

const List<String> season = [
  'Summer',
  'Winter',
  'Rainy'
];