import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epuka/utils/SmartLoader.dart';
import 'package:flutter/material.dart';


class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  Future _data;

  @override
  void initState() {
    super.initState();
    _data = getSugg();
  }

  Future getSugg() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("suggestion").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SmartLoader());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Card(
                      child: ListTile(
                        title: Text("${snapshot.data[index].data["titre"]}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),),
                        subtitle: Text(
                          "${snapshot.data[index].data["suggestion"]}",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey),),
                      ),
                    );
                  }
              );
            }
          }),
    );
  }
}
