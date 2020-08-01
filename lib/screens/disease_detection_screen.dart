import 'dart:convert' show base64Encode;
import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:farmhelper/screens/homescreen.dart';
import 'package:farmhelper/utilities/constants.dart';
import 'package:farmhelper/utilities/networking/api_helper.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:farmhelper/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  static const String id = 'disease';

  @override
  _DiseaseDetectionScreenState createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File _imageFile;
  bool _showSpinner = false;

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(
      source: source,
      imageQuality: 50,
//      maxHeight: 224,
//      maxWidth: 224,
    );

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  Text get getInitialText => Text(
        'Click a picture of the leaf of the plant or select an image from the Gallery',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.black54,
        ),
      );

  Image get getImageWidget => Image.file(
        _imageFile,
      );

  /// Toggle spinner visibility
  void toggleSpinner() {
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Scaffold(
          backgroundColor: Color(0xFFADEFD1),
          // Select an image from the camera or gallery
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: ClipRRect(
                        child: _imageFile == null
                            ? getInitialText
                            : getImageWidget,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _imageFile != null,
                  child: Builder(
                    builder: (context) => Button(
                      buttonColor: Color(0xFF53d45b),
                      buttonText: 'Detect Disease',
                      onPress: () async {
                        toggleSpinner();
                        Uint8List bytesImg = _imageFile.readAsBytesSync();
//                    var bytesImg = imgLib.encodeJpg(
//                        imgLib.decodeImage(_imageFile.readAsBytesSync()));
                        String base64EncodedImg = base64Encode(bytesImg);
                        String detectedDisease =
                            await ApiHelper().detectDisease(base64EncodedImg);
                        toggleSpinner();

                        if (detectedDisease != null) {
                          Alert(
                            context: context,
                            title: 'Detected Disease',
                            desc: detectedDisease,
                            type: AlertType.success,
                            buttons: [],
                            closeFunction: () => Navigator.popUntil(
                              context,
                              ModalRoute.withName(HomeScreen.id),
                            ),
                          ).show();
                        } else {
                          showSnackBarMessage(
                            context: context,
                            snackBarText:
                                'Something went wrong! Please try again',
                            backgroundColor: kSnackBarErrorColor,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
