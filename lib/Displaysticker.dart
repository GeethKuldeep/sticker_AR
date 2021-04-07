import 'dart:io';

import 'package:flutter/material.dart';

class DisplayUploadedPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayUploadedPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("How's the pic")),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}