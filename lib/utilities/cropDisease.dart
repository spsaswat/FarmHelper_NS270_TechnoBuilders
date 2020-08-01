class CropDisease {
  final Map<String, List> _diseaseDetails = {
    'Tomato___Tomato_Yellow_Leaf_Curl_Virus': [
      'Tomato',
      'Yellow Leaf Curl Virus',
      0.0,
    ],
    'Tomato__Late_blight': [
      'Tomato',
      'Late Blight',
      1.0,
    ],
    'Tomato___Septoria_leaf_spot': [
      'Tomato',
      'Septoria Leaf Spot',
      2.0,
    ],
    'Tomato___Tomato_mosaic_virus': [
      'Tomato',
      'Mosaic Virus',
      3.0,
    ],
    'Tomato___Spider_mites Two-spotted_spider_mite': [
      'Tomato',
      'Spider mites Two-spotted spider mite',
      4.0,
    ],
    'Tomato___Leaf_Mold': [
      'Tomato',
      'Leaf Mold',
      5.0,
    ],
    'Tomato___Early_blight': [
      'Tomato',
      'Early Blight',
      6.0,
    ],
    'Tomato___Bacterial_spot': [
      'Tomato',
      'Bacterial Spot',
      7.0,
    ],
    'Tomato___Target_spot': [
      'Tomato',
      'Target Spot',
      8.0,
    ],
    'Potato__Late_blight': [
      'Potato',
      'Late Blight',
      9.0,
    ],
    'Potato__Early_blight': [
      'Potato',
      'Early Blight',
      10.0,
    ],
    'Corn_(maize)___Northern_Leaf_Blight': [
      'Corn(maize)',
      'Northern Leaf Blight',
      11.0,
    ],
    'Corn_(maize)___Common_rust': [
      'Corn(maize)',
      'Common Rust',
      12.0,
    ],
    'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot': [
      'Corn(maize)',
      'Cercospora Leaf Spot Gray Leaf Spot',
      13.0,
    ],
    'Potato_healthy': [
      'Potato',
      'Healthy',
      -1.0,
    ],
    'Tomato_healthy': [
      'Tomato',
      'Healthy',
      -1.0,
    ],
    'Corn(maize)__healthy': [
      'Corn(maize)',
      'Healthy',
      -1.0,
    ],
  };
  String _crop, _disease;
  double _diseaseCode;

  String get crop => _crop;

  String get disease => _disease;

  double get diseaseCode => _diseaseCode;

  CropDisease({String packedCropDiseaseDetails}) {
    _crop = _diseaseDetails[packedCropDiseaseDetails][0];
    _disease = _diseaseDetails[packedCropDiseaseDetails][1];
    _diseaseCode = _diseaseDetails[packedCropDiseaseDetails][2];
  }
}
