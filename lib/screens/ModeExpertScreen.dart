import 'package:epuka/pages/ChatScreen.dart';
import 'package:epuka/pages/StatUserPage.dart';
import 'package:epuka/pages/SuggestionPage.dart';
import 'package:epuka/screens/ConseilScreenPage.dart';
import 'package:epuka/screens/PostScreenPage.dart';
import 'package:epuka/screens/StatistiqueScreen.dart';
import 'package:epuka/utils/Constants.dart';
import 'package:flutter/material.dart';


class ExpertScreen extends StatefulWidget {
  final String currentUserId;

  ExpertScreen({this.currentUserId});

  @override
  _ExpertScreenState createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mode Expert"),
        bottom: TabBar(
            controller: _tabController,
            tabs: [
              new Tab(text: "chats",),
              new Tab(text: "Suggest",),
              new Tab(text: "Usage",)
            ]),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.expertChoices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          new ChatScreen(),
          new SuggestionPage(),
          new StatUserPage(),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Statistique) {
      // mover de l'ecran principale vers le ModeExpert
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => StatistiqueScreen()));
      print('statistique');
    } else if (choice == Constants.Conseil) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConseilScreenPage()));
      print('conseil');
    } else if (choice == Constants.Post) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PostScreenPage()));
      print('post');
    }
  }
}
