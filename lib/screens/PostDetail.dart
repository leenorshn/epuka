import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epuka/component/card_post_comment.dart';
import 'package:epuka/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostDetail extends StatefulWidget {
  final DocumentSnapshot post;

  PostDetail({this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController=new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Detail"),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.post.data["image"],
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.post.data["contenu"],
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            color: Colors.lightBlue,
            child: SizedBox(
              height: 30.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Text(
                  "Commentaire",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          buildInput()
          ,
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child:  StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('posts').document(widget.post.documentID).collection("comment").orderBy("date",descending: true).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return new ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        //print("${snapshot.data.documents[index].data["image"]}");
                        //var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data.documents[index].data["date"]) * 1000);
                        return CardPostComment(
                          comment:"${snapshot.data.documents[index].data["comment"]}" ,
                          date: "${readTimestamp(int.parse(snapshot.data.documents[index].data["date"]))}",
                        );
                      },
                    );
                }
              },
            ),
          )
        ],
      )),
    );
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.mic),
                onPressed: () {},
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Tappez votre commentaire...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                //focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  // _add();
                  onSendMessage(textEditingController.text);
                },
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
          new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  void onSendMessage(String content) {
   // _ensureLoggedIn();
    if (content.trim() != '') {
      textEditingController.clear();

      print(content);

      var documentReference =
      Firestore.instance.collection('posts').document(widget.post.documentID).collection("comment").document();

      Map<String, dynamic> data = <String, dynamic>{
        'date': DateTime.now().millisecondsSinceEpoch.toString(),
        'comment': content,

      };

      documentReference.setData(data).whenComplete(() {
        print("Document Added");
      }).catchError((e) => print(e));



    }
  }
}
