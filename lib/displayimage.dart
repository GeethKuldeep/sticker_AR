import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'Displaysticker.dart';



class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  upload(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://131c59517e50.ngrok.io/transfer/");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    var result = await http.Response.fromStream(response);
    print("hello");
    print(result.body.runtimeType);
    var imagesource = json.decode(result.body);
    print(imagesource);
    final File image = await ImagePicker.pickImage(source: imagesource);
    final path1 = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png',
    );
    final finalpath = await image.copy('$path1/image1.png');
    return finalpath.path;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("How's the pic")),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: (){
          var img = upload(File(imagePath));
          print("Sticker Path = ${img.toString()}");
          //Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayUploadedPictureScreen(imagePath: img),));
        },
      ),
    );
  }
}