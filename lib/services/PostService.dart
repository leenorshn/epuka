import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  bool isConnected() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addPost(data) async {
    Firestore.instance.collection("posts").add(data).whenComplete(() {
      print("post added");
    }).catchError((e) => print(e));
  }
}
