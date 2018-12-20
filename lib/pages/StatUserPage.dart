import 'package:flutter/material.dart';

class StatUserPage extends StatefulWidget {
  @override
  _StatUserPageState createState() => _StatUserPageState();
}

class _StatUserPageState extends State<StatUserPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Text(
        "Usages ",
        style: TextStyle(fontSize: 25.0),
      ),
    );
  }
}
