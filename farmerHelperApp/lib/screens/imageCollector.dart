import 'dart:io' show File;

import 'package:farmhelper/screens/reportscreen.dart';
import 'package:farmhelper/utilities/Locate.dart';
import 'package:farmhelper/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ImageCollect extends StatefulWidget {
  static const String id = 'imagesCollect';
  @override
  _ImageCollectState createState() => _ImageCollectState();
}

class _ImageCollectState extends State<ImageCollect> {
  File _imageFile;
  bool _showSpinner = false;
  int numberOfImagesRequired = 4;
  List<File> pickedImagePaths = [];
  List<double> latitudes = [];
  List<double> longitudes = [];

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(
      source: source,
      imageQuality: 50,
//      maxHeight: 224,
//      maxWidth: 224,
    );
    setState(() {
      numberOfImagesRequired--;
      _imageFile = File(selected.path);

      pickedImagePaths.add(_imageFile);
      _showSpinner = true;

    });
    Location obj = Location();
    await obj.locate();
//    print(obj.lat);
//    print(obj.long);
    latitudes.add(obj.lat);
    longitudes.add(obj.long);

    setState(() {

      _showSpinner = false;

    });
  }

  Text get getInitialText => Text(
        "You have to upload $numberOfImagesRequired number of images to proceed. You can click one by one.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.black54,
        ),
      );

  Image get getImageWidget => Image.file(
        _imageFile,
      );

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
                      child: ClipRect(
                        child: numberOfImagesRequired > 0
                            ? getInitialText
                            : getImageWidget,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: numberOfImagesRequired == 0,
                  child: Builder(
                    builder: (context) => Button(
                      buttonColor: Color(0xFF53d45b),
                      buttonText: "Proceed",
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportScreen(
                              lat: latitudes,
                              lon: longitudes,
                              imageFiles: pickedImagePaths,
                            ),
                          ),
                        );
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
