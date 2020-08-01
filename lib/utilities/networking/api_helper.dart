import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  final String _yieldPredictionApiURL = "https://sihcypapi.herokuapp.com/";
  final String _diseaseDetectionApiURL =
      "https://sihcypapi.herokuapp.com/image2";

  Future<double> getYieldPrediction(String crop, String district, String year,
      String season, String fieldArea) async {
    var requestBody = {
      'DISTRICT': district,
      'YEAR': year,
      'CROP': crop,
      'AREA': fieldArea,
      'SEASON': season,
    };
    try {
      var responseData = await http.post(
        _yieldPredictionApiURL,
        body: jsonEncode(requestBody),
      );
      if (responseData.statusCode == 200) {
        return jsonDecode(responseData.body);
      } else {
        print(responseData.statusCode);
        return null;
      }
    } catch (e) {
      print('api_helper.dart: $e');
      return null;
    }
  }

  Future<String> detectDisease(String img) async {
    try {
//    print('imgString: ${img.length} ,$img');  // Debugging
//    print('Post request'); // Debugging
      var responseData = await http.post(
        _diseaseDetectionApiURL,
        headers: {'content-type': 'image/jpeg'},
        body: img,
      );
//    print('Response received'); // Debugging
      if (responseData.statusCode == 200) {
        return jsonDecode(responseData.body)['message'];
      } else {
        throw ('Status code of ${responseData.statusCode}');
      }
    } catch (e) {
      print('api_helper.dart: Error in detectDisease(); $e');
      return null;
    }
  }
}
