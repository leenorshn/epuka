import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epuka/utils/SmartLoader.dart';
import 'package:flutter/material.dart';


class ConseilPage extends StatefulWidget {
  @override
  _ConseilPageState createState() => _ConseilPageState();
}

class _ConseilPageState extends State<ConseilPage> {
  Future _data;

  @override
  void initState() {
    super.initState();
    _data = getConseil();
  }

  Future getConseil() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("conseil").getDocuments();

    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ConseilDetail(
                  post: ds,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _data,
            builder: (BuildContext context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SmartLoader());
              } else {
                return ListView.builder(

                    padding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      //return Text(snapshot.data[index].data["contenu"]);

                      DocumentSnapshot document = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            "${ document["titre"]}",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "${ document["contenu"].substring(0, 25)} ...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,),
                            textAlign: TextAlign.justify,
                          ),
                          trailing: Text("lire plus",
                            style:
                            TextStyle(fontSize: 14.0, color: Colors.blue),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () => navigateToDetail(snapshot.data[index]),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}

// detaile du conseil

class ConseilDetail extends StatefulWidget {
  final DocumentSnapshot post;

  ConseilDetail({this.post});

  @override
  _ConseilDetailState createState() => _ConseilDetailState();
}

class _ConseilDetailState extends State<ConseilDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.post.data["titre"]),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.post.data["contenu"],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}
