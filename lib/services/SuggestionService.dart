import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuggService {
  bool isConnected() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addSugg(data) async {
    Firestore.instance.runTransaction((Transaction sugtransaction) async {
      CollectionReference reference =
          Firestore.instance.collection("suggestion");
      reference.add(data).catchError((e) => print(e));
    });

    /*Firestore.instance.collection("suggestion").add(data).whenComplete((){
      print("post added");
    }).catchError((e)=>print(e));*/
  }

  Future getData() async {
    return Firestore.instance.collection("suggestion").getDocuments();
  }
}
