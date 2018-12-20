import 'dart:io';

import 'package:epuka/services/PostService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class PostScreenPage extends StatefulWidget {
  @override
  _PostScreenPageState createState() => _PostScreenPageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _PostScreenPageState extends State<PostScreenPage> {
  final formKey = GlobalKey<FormState>();

  AppState state;
  File sampleImage;

  String _content,_titre;

  bool isLoading;
  bool isShowSticker;
  String _imageUrl;

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
      state = AppState.picked;
    });

  File croppedFile = await ImageCropper.cropImage(
      sourcePath: sampleImage.path,
      ratioX: 1.0,
      ratioY: 1.0,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
    );
    if (croppedFile != null) {
      sampleImage = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  /*Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: sampleImage.path,
      ratioX: 1.0,
      ratioY: 1.0,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
    );
    if (croppedFile != null) {
      sampleImage = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }*/

  Future upLoadImage() async {
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('post_image/$fileName.jpg');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
    StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
    _imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (validateAndSave()) {
      Map<String, dynamic> data = {
        "image": _imageUrl != null ? _imageUrl : "default",
        "contenu": _content,
        "titre":_titre,
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch
            .toString()
      };

      PostService postService = new PostService();

      postService.addPost(data).then((result) {
        print("Conseil ajouter ");
        // analyse de donnee avec firebase analitique
      }).catchError((e) => print(e));

      formKey.currentState.reset();
    }
  }

  Widget ajouterPhoto() {
    return GestureDetector(
      onTap: () {
        getImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.add_a_photo,
          size: 30.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    state = AppState.free;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post sur la MVE"),
        actions: <Widget>[
          ajouterPhoto(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Merci de poster une actualité sur la MVE",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    child: sampleImage != null
                        ? Image.file(
                      sampleImage,
                      fit: BoxFit.cover,
                    )
                        : Container(),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    onSaved: (value) => _titre = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "titre MVE",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    onSaved: (value) => _content = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "Actualité MVE",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    splashColor: Colors.deepOrange,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: Text(
                        "Soumettre",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: upLoadImage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearImage() {
    sampleImage = null;
    setState(() {
      state = AppState.free;
    });
  }
}
