import 'package:flutter/material.dart';

// Data
const int kPhoneNumberLength = 10;
const int kOTPLength = 6;
const String kCountryCode = '+91';
const String kFirstTimeUserSharedPrefsKey = 'firstTimeUser';

// <editor-fold desc="kCropList" default="collapsed">
const List<String> kCropList = [
  'ARHAR (TUR)',
  'BAJRA',
  'BANANA',
  'BARLEY',
  'CASTOR SEED',
  'CORIANDER',
  'DRY CHILLIES',
  'DRY GINGER',
  'GARLIC',
  'GRAM',
  'GROUNDNUT',
  'HORSEGRAM',
  'JOWAR',
  'JUTE',
  'KESARI',
  'LINSEED',
  'MAIZE',
  'MASOOR',
  'MESTA',
  'MOONG',
  'ONION',
  'OTHER KHARIF PULSES',
  'OTHER RABI PULSES',
  'PEAS & BEANS (PULSES)',
  'POTATO',
  'RAGI',
  'RAPESEED &MUSTARD',
  'RICE',
  'SAFFLOWER',
  'SANNHAMP',
  'SESAMUM',
  'SMALL MILLETS',
  'SUGARCANE',
  'SUNFLOWER',
  'SWEET POTATO',
  'TOBACCO',
  'TURMERIC',
  'URAD',
  'WHEAT',
];
// </editor-fold>

// <editor-fold desc="kMonths" default="collapsed">
const List<String> kMonths = [
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
  'DEC',
];
// </editor-fold>

// <editor-fold desc="kSeasons" default="collapsed">
const List<String> kSeasons = [
  'AUTUMN',
  'KHARIF',
  'RABI',
  'SUMMER',
  'WINTER',
  'TOTAL ',
  'WHOLE YEAR',
];
// </editor-fold>

// <editor-fold desc="kDistricts" default="collapsed">
const List<String> kDistricts = [
  'Araria',
  'Arhasia',
  'Arval',
  'Aurangabad',
  'Banka',
  'Begusarai',
  'Bhagalpur',
  'Bhanka',
  'Bhojpur',
  'Buxar',
  'Darbhanga',
  'Devghar',
  'Dumka',
  'Gadhwa',
  'Gaya',
  'Giridih',
  'Godda',
  'Gopalganj',
  'Gumala',
  'Hazaribagh',
  'Jamui',
  'Jehanabad',
  'Kaimur (Bhabua)',
  'Katihar',
  'Khagaria',
  'Kishanganj',
  'Lakhisarai',
  'Lohardanga',
  'Madhepura',
  'Madhubani',
  'Munger',
  'Muzaffarpur',
  'Nalanda',
  'Nawada',
  'Palamau',
  'Pashchim Champaran',
  'Patna',
  'Purba Champaran',
  'Purnia',
  'Ranchi',
  'Rohtas',
  'Saharsa',
  'Sahebganj',
  'Samastipur',
  'Saran',
  'Sheikhpura',
  'Sheohar',
  'Singhbhum',
  'Singhbhur(west)',
  'Sitamarhi',
  'Siwan',
  'Sumal',
  'Supaul',
  'Vaishali',
  'Zamui',
];
// </editor-fold>

// <editor-fold desc="kSupportedLanguages" default="collapsed">
const List<String> kSupportedLanguages = [
  'en',
  'hi',
];
// </editor-fold>

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
const kOptionstyles2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kCardDecoration = BoxDecoration(
//  color: Color(0xFFb6bab7),
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xffa8ff78), Color(0xff78ffd6)],
  ),
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

const kLargeText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: Colors.white,
);

const kActiveIcon = Color(0xFF6eeb60);
const kInactiveIcon = Color(0xFFb0b0b0);

// <editor-fold desc="SnackBar Colors" default="collapsed">
const Color kSnackBarWarningColor = Colors.redAccent;
const Color kSnackBarErrorColor = Colors.orangeAccent;
// </editor-fold>

// <editor-fold desc="Slider Colors" default="collapsed">
const Color kSliderActiveColor = Color(0xFFFF5E5E);
const Color kSliderInactiveColor = Colors.white70;
// </editor-fold>

const List<String> kFaliures = [
  'Drought',
  'Disease',
  'Floods',
  'Insects',
  'Animal Destruction',
  'Not Listed Here',
];

const List<String> kCropStatus = [
  'Sowing',
  'Irrigation',
  'Ploughing',
  'Harvesting',
];

const kChatBot = TextStyle(
  fontSize: 25,
  backgroundColor: Colors.black12,
);
