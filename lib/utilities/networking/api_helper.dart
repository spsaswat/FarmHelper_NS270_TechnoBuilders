import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  static const String _yieldPredictionApiURL =
      "https://sihapiv3.herokuapp.com/";
  static const String _yieldInfectedPlantApiURL =
      "https://sihapiv3.herokuapp.com/dis";
  static const String _diseaseDetectionApiURL =
      "https://sihapiv3.herokuapp.com/image";

  static Future<double> getYieldPrediction(String crop, String district,
      String year, String season, String fieldArea) async {
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

  static Future<String> detectDisease(String img) async {
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
