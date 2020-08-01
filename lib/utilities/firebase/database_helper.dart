import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models.dart';

final _firestore = Firestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

// Helper Functions
Future<bool> doesPhoneNumberExists(String phoneNumber) async {
  final QuerySnapshot result = await _firestore
      .collection(UsersCollection.collectionName)
      .where(UsersCollection.fieldPhoneNumber, isEqualTo: phoneNumber)
      .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  return documents.length > 0;
}

void addRegisteredUserDetails(
    String phoneNumber, String userName, String district) async {
  if (await doesPhoneNumberExists(phoneNumber) == false) {
    _firestore
        .collection(UsersCollection.collectionName)
        .document('$phoneNumber')
        .setData({
      UsersCollection.fieldPhoneNumber: phoneNumber,
      UsersCollection.fieldName: userName,
      UsersCollection.fieldArea: '1000.0',
      UsersCollection.fieldDistrict: district,
      UsersCollection.fieldCreated: FieldValue.serverTimestamp(),
    });
  } else {
    updateRegisteredUserDetails(
      phoneNumber,
      userName: userName,
      district: district,
    );
  }
}

void updateRegisteredUserDetails(String phoneNumber,
    {String userName, String district, String area}) async {
  Map<String, dynamic> updatedData = {};
  if (userName != null)
    updatedData.addAll({UsersCollection.fieldName: userName});
  if (district != null)
    updatedData.addAll({UsersCollection.fieldDistrict: district});
  if (area != null) updatedData.addAll({UsersCollection.fieldArea: area});

  _firestore
      .collection(UsersCollection.collectionName)
      .document('$phoneNumber')
      .updateData(updatedData);
}

void reportFailure(
    {String crop, String area, String estimatedYield, String fails}) async {
  FirebaseUser user = await _auth.currentUser();
  _firestore.collection(FailureCollection.collectionName).add({
    FailureCollection.fieldArea: area,
    FailureCollection.fieldCrop: crop,
    FailureCollection.fieldEstimatedYield: estimatedYield,
    FailureCollection.fieldReason: fails,
    FailureCollection.fieldUserPhoneNumber: user.phoneNumber,
    FailureCollection.fieldStatus: 'f',
    FailureCollection.fieldCreated: FieldValue.serverTimestamp(),
  });
}

void addYieldPredictedWithoutDisease(String crop, String district, String year,
    String season, String area, String predictedYield) async {
  FirebaseUser user = await _auth.currentUser();
  _firestore
      .collection(
          '${UsersCollection.collectionName}/${user.phoneNumber}/${YPwoDCollection.collectionName}')
      .add({
    YPwoDCollection.fieldUserPhoneNumber: user.phoneNumber,
    YPwoDCollection.fieldCrop: crop,
    YPwoDCollection.fieldDistrict: district,
    YPwoDCollection.fieldYear: year,
    YPwoDCollection.fieldArea: area,
    YPwoDCollection.fieldSeason: season,
    YPwoDCollection.fieldPredictedYield: predictedYield,
    YPwoDCollection.fieldCreated: FieldValue.serverTimestamp(),
  });
}

void addYieldPredictedWithDisease(
    String crop,
    String disease,
    String diseaseCode,
    String areaAffected,
    String stage,
    String predictedYield) async {
  FirebaseUser user = await _auth.currentUser();
  _firestore
      .collection(
          '${UsersCollection.collectionName}/${user.phoneNumber}/${YPwDCollection.collectionName}')
      .add({
    YPwDCollection.fieldUserPhoneNumber: user.phoneNumber,
    YPwDCollection.fieldCrop: crop,
    YPwDCollection.fieldDisease: disease,
    YPwDCollection.fieldDiseaseCode: diseaseCode,
    YPwDCollection.fieldAreaAffected: areaAffected,
    YPwDCollection.fieldStage: stage,
    YPwDCollection.fieldPredictedYield: predictedYield,
    YPwDCollection.fieldCreated: FieldValue.serverTimestamp(),
  });
}

/*
References:
  https://stackoverflow.com/questions/51122211/check-if-field-already-exists-in-flutter-firestore (for doesPhoneNumberExists)
  
 */
