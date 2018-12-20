import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  bool isConnected() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addPost(data) async {
    if (isConnected()) {
      Firestore.instance.runTransaction((Transaction chatTransaction) async {
        CollectionReference reference =
            Firestore.instance.collection("message");
        reference.add(data).catchError((e) => print(e));
      });
    } else {
      print("u must be loggin");
    }
  }
}
