import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConseilService {
  bool isConnected() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addConseil(data) async {
    Firestore.instance.collection("conseil").add(data).whenComplete(() {
      print("conseil added");
    }).catchError((e) => print(e));
  }
}
