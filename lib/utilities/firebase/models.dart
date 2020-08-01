// Models for Database in Cloud Firestore

// User data collection during Phone Authentication
class UsersCollection {
  static String collectionName = 'users';
  static String fieldCreated = 'created';
  static String fieldDistrict = 'district';
  static String fieldPhoneNumber = 'registeredPhoneNumber';
}

// Report Failure data collection on ReportScreen
class FailureCollection {
  static String collectionName = 'failure';
  static String fieldUserPhoneNumber = 'registeredPhoneNumber';
  static String fieldCreated = 'created';
  static String fieldArea = 'area';
  static String fieldCrop = 'crop';
  static String fieldEstimatedYield = 'estimatedYield';
  static String fieldReason = 'reason';
}
