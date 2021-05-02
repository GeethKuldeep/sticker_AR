import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class DisplayStickerScreen extends StatefulWidget {
  final String base64imagestring;

  const DisplayStickerScreen({Key key, this.base64imagestring}) : super(key: key);

  @override
  _DisplayStickerScreenState createState() => _DisplayStickerScreenState();
}


class _DisplayStickerScreenState extends State<DisplayStickerScreen> {
  Image image;
  @override
  void initState() {
     image = Image.memory(base64Decode(widget.base64imagestring));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("How's the pic")),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          if(image!=null)
            image,
          Text("Nothing is recieved")
        ],
      )
    );
  }
}