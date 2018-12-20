import 'package:flutter/material.dart';

class CardConseilItem extends StatelessWidget {

  final String titre;
  final String conseil;
  final String date;

  CardConseilItem({this.conseil,this.titre,this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child:new Container(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(titre),
          subtitle: Text("${conseil.substring(0, 30)} ..."),
          trailing: Text(date),
        ),
      ),
    );
  }
}
