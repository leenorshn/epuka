import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epuka/component/CardPostItem.dart';
import 'package:epuka/screens/PostDetail.dart';
import 'package:epuka/utils/SmartLoader.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return CardPostItem(
      title: document["titre"],
      contenu: document["contenu"],
      image: document["image"],
      onTapItem: (){
        navigateToPostDetail(document);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('posts').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return new ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      print("${snapshot.data.documents[index].data["image"]}");
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    },
                  );
              }
            },
          ),
        ));
  }

  navigateToPostDetail(DocumentSnapshot document) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PostDetail(post: document,)));
  }
}
