import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardPostComment extends StatelessWidget {
  final String comment;
  final String date;

  CardPostComment({this.date,this.comment});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      child: Container(
        child: ListTile(
          title: Text("${comment}"),
          subtitle: Text("${date}"),
          trailing: CircleAvatar(
           child: Icon(Icons.person),
          ),
        )
      ),
    );
  }
}
