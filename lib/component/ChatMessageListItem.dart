import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var currentUserEmail;

class ChatMessageListItem extends StatelessWidget {
  final DocumentSnapshot document;
  final int index;

  ChatMessageListItem({this.index, this.document});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        children: currentUserEmail == document['email']
            ? getSentMessageLayout()
            : getReceivedMessageLayout(),
      ),
    );
  }

  Widget sender() {
    return Card(
      child: Container(
        width: 200.0,
        padding: EdgeInsets.only(right: 50.0),
        child: ListTile(
          leading: new CircleAvatar(
            backgroundImage: new NetworkImage("${document['senderPhotoUrl']}"),
          ),
          title: new Text("${document['senderName']}",
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          subtitle: new Text("${document['message']}",
              style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text("${document['senderName']}",
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text("${document['message']}"),
            ),
          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                    new NetworkImage("${document['senderPhotoUrl']}"),
              )),
        ],
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                    new NetworkImage("${document['senderPhotoUrl']}"),
              )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("${document['senderName']}",
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text("${document['message']}"),
            ),
          ],
        ),
      ),
    ];
  }
}
