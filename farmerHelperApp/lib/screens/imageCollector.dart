import 'package:flutter/material.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:farmhelper/widgets/button.dart';

class ImageCollect extends StatefulWidget {
  static const String id = 'imagescollect';
  @override
  _ImageCollectState createState() => _ImageCollectState();
}

class _ImageCollectState extends State<ImageCollect> {
  File _imageFile;
  bool _showSpinner = false;
  int l=4;
  List<File> arr = [];
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
      l--;
      arr.add(_imageFile);
    });
  }

  Text get getInitialText => Text("You have to upload $l number of images to proceed. You can click one by one.",
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
                        child: l>0?getInitialText:getImageWidget,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: l == 0,
                  child: Builder(
                    builder: (context) => Button(
                      buttonColor: Color(0xFF53d45b),
                      buttonText: "Proceed",
                      onPress: (){},
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
