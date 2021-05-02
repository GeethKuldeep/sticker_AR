import 'dart:convert';
import 'dart:io';
import 'package:ar_sticker_app/Displaysticker.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;



class DisplayPictureScreen extends StatefulWidget {

  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  String encode;
  Image Sticker_image;
  bool cool = false;
  upload(File imageFile) async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://98fa146f8050.ngrok.io/transfer/");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    print("Hello1");
    var result = await http.Response.fromStream(response);
    print("Hello2");
    var imagesource = result.body;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    encode= stringToBase64.encode(imagesource);
    print("Hello3");
    print("imagesourse in string format${imagesource}");
    print("encoded to base64 ${encode}");
    print("Hello4");
    setState(() {
         Sticker_image = Image.memory(base64Decode(encode));
        print("Final Sticker Image:${Sticker_image}");
      });

/*
     final File image = await ImagePicker.pickImage(source: imagesource);
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
// copy the file to a new path
    await image.copy('$path/image1.png');
    */

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("How's the pic")),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(widget.imagePath)),
          if(Sticker_image!=null)
            Sticker_image
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: (){
          print("Original Image path:${widget.imagePath}");
          upload(File(widget.imagePath));
          print("Stcker Image ${ Sticker_image}");
          //print("Sticker Path = ${img.toString()}");0
          //Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayStickerScreen(base64imagestring: encode,)),);
        },
      ),
    );
  }
}