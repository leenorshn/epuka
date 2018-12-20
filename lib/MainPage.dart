import 'package:epuka/pages/ConseilPage.dart';
import 'package:epuka/pages/HomePage.dart';
import 'package:epuka/pages/StatistiquePage.dart';
import 'package:epuka/screens/AddSuggessionScreen.dart';
import 'package:epuka/screens/SecretCodeScreen.dart';
import 'package:epuka/utils/Constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{
  TabController _tabController;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  
  @override
  void initState() {
    super.initState();
    firebaseMessaging.getToken().then((token) {
      print(token);
    });


    _tabController=TabController(length: 3, vsync: this,initialIndex: 0);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Epuka Ebola"),
       actions: <Widget>[
         Stack(
           alignment: Alignment.topLeft,
           children: <Widget>[
             IconButton(icon: Icon(Icons.notifications,size: 30.0,), onPressed: (){}),
             Padding(
               padding: const EdgeInsets.only(left:2.0,top: 2.0),
               child: Container(
                 padding: EdgeInsets.all(3.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Colors.green
                 ),
                 child: Text("+0",
                   style: TextStyle(color: Colors.white, fontSize: 12.0),),),
             )
           ],
         ),
          //popup menu pour tout le menu cacher
         PopupMenuButton<String>(
           onSelected: choiceAction,
           itemBuilder: (BuildContext context){
             return Constants.choices.map((String choice){
               return PopupMenuItem<String>(
                 value: choice,
                 child: Text(choice),
               );
             }).toList();
           },
         )

       ],
       bottom: TabBar(
         controller: _tabController,
           tabs: [
         new Tab(text: "Accueil",),
         new Tab(text: "Conseils",),
         new Tab(text: "Statistiques",)
       ]),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
            new HomePage(),
            new ConseilPage(),
            new StatistiquePage()
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>AddSuggestionScreen()));
          },
        child: Icon(Icons.hearing),
        backgroundColor: Colors.green,
      ),
      
      
    );
  }

  void choiceAction(String choice){
    if(choice == Constants.ModeExpert){
      // mover de l'ecran principale vers le ModeExpert
      Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>SecretCode()));
      print('Mode expert');
    }else if(choice == Constants.Deconnexion){
      Scaffold.of(context).showSnackBar(
        new SnackBar(content: Text("SignOut in now cliqued"),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
      print('SignOut');
    }
  }
}
