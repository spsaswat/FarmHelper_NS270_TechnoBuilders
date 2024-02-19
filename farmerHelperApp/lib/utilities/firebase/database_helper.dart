/*
This Dart file contains helper functions for interacting with Firebase Firestore and FirebaseAuth services for a farming-related app. The functions perform the following tasks:

1. `doesPhoneNumberExists`: Asynchronously checks if a user's phone number is already registered in the Firestore database. It queries the `UsersCollection` using the phone number and returns a boolean indicating the existence of the record.

2. `addRegisteredUserDetails`: Adds a new user's details to Firestore if their phone number does not already exist in the database. It sets data such as phone number, user name, district, and a server timestamp for creation time. If the phone number exists, it calls `updateRegisteredUserDetails` to update the user's information.

3. `updateRegisteredUserDetails`: Updates the details of an existing user in Firestore. It accepts user name, district, and area as optional parameters to update in the user's record.

4. `reportFailure`: Allows users to report crop failure incidents. The function collects various parameters such as crop type, affected area, reasons for failure, geolocation data, and image file names to document the failure incident. It then creates a new document in the `FailureCollection` with the provided data along with the user's phone number and a server timestamp.

5. `addYieldPredictedWithoutDisease`: Adds predicted yield data for a crop without disease factors to a user-specific subcollection in Firestore. It records details such as crop, district, year, season, area, and the predicted yield along with a server timestamp.

6. `addYieldPredictedWithDisease`: Similar to the previous function, this adds predicted yield data considering disease factors. It includes additional fields to record the disease name, disease code, area affected by the disease, the stage of the crop, and the predicted yield.

All functions utilize the Firebase Authentication instance to retrieve the current user and interact with Firestore using the user's phone number as a key or part of the document path for user-specific collections.
*/

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

void reportFailure({
  String crop,
  String area,
  String givenYield,
  String fails,
  List<double> latitudes,
  List<double> longitudes,
  List<String> imageFileNames,
}) async {
  FirebaseUser user = await _auth.currentUser();
  _firestore.collection(FailureCollection.collectionName).add({
    FailureCollection.fieldArea: area,
    FailureCollection.fieldCrop: crop,
    FailureCollection.fieldYield: givenYield,
    FailureCollection.fieldReason: fails,
    FailureCollection.fieldUserPhoneNumber: user.phoneNumber,
    FailureCollection.fieldStatus: 'f',
    FailureCollection.fieldCreated: FieldValue.serverTimestamp(),
    FailureCollection.fieldLat1: latitudes[0],
    FailureCollection.fieldLat2: latitudes[1],
    FailureCollection.fieldLat3: latitudes[2],
    FailureCollection.fieldLat4: latitudes[3],
    FailureCollection.fieldLon1: longitudes[0],
    FailureCollection.fieldLon2: longitudes[1],
    FailureCollection.fieldLon3: longitudes[2],
    FailureCollection.fieldLon4: longitudes[3],
    FailureCollection.fieldImg1: imageFileNames[0],
    FailureCollection.fieldImg2: imageFileNames[1],
    FailureCollection.fieldImg3: imageFileNames[2],
    FailureCollection.fieldImg4: imageFileNames[3],
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
