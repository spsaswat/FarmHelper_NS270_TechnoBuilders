// Models for Database in Cloud Firestore

// User data collection during Phone Authentication
class UsersCollection {
  static String collectionName = 'users';
  static String fieldCreated = 'created';
  static String fieldDistrict = 'district';
  static String fieldName = 'name';
  static String fieldArea = 'area';
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
  static String fieldStatus = 'status';
  static String fieldLat1 = 'latitude1';
  static String fieldLat2 = 'latitude2';
  static String fieldLat3 = 'latitude3';
  static String fieldLat4 = 'latitude4';
  static String fieldLon1 = 'longitude1';
  static String fieldLon2 = 'longitude2';
  static String fieldLon3 = 'longitude3';
  static String fieldLon4 = 'longitude4';
}

// Yield Prediction without Disease
class YPwoDCollection {
  static String collectionName = 'yieldWithoutDisease';
  static String fieldUserPhoneNumber = 'registeredPhoneNumber';
  static String fieldCreated = 'created';
  static String fieldCrop = 'crop';
  static String fieldDistrict = 'district';
  static String fieldYear = 'year';
  static String fieldSeason = 'season';
  static String fieldArea = 'area';
  static String fieldPredictedYield = 'predictedYield';
}

// Yield Prediction with Disease
class YPwDCollection {
  static String collectionName = 'yieldWithDisease';
  static String fieldUserPhoneNumber = 'registeredPhoneNumber';
  static String fieldCreated = 'created';
  static String fieldCrop = 'crop';
  static String fieldDisease = 'disease';
  static String fieldDiseaseCode = 'diseaseCode';
  static String fieldAreaAffected = 'area';
  static String fieldStage = 'stage';
  static String fieldPredictedYield = 'predictedYield';
}
