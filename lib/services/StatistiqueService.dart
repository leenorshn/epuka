import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatistiqueService {
  bool isConnected() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addStat(data) async {
    Firestore.instance
        .collection("statistique")
        .add(data)
        .catchError((e) => print(e));
  }
}
