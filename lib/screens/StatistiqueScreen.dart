import 'package:epuka/services/StatistiqueService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';


class StatistiqueScreen extends StatefulWidget {
  @override
  _StatistiqueScreenState createState() => _StatistiqueScreenState();
}

class _StatistiqueScreenState extends State<StatistiqueScreen> {
  final formKey = GlobalKey<FormState>();


  final analytics = new FirebaseAnalytics();

  String _milieu;
  String _detail;
  String _suspect;
  String _probable;
  String _confirmer;
  String _gueri;
  String _vacciner;
  String _deceder;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void onSendMessage() {
    StatistiqueService statistiqueService = new StatistiqueService();

    if (validateAndSave()) {
      Map<String, dynamic> statistiqueData = {
        "milieu": _milieu,
        "detail": _detail,
        "suspect": _suspect,
        "probable": _probable,
        "gueri": _gueri,
        "confirmer": _confirmer,
        "deceder": _deceder,
        "vacciner": _vacciner,
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
      };

      statistiqueService.addStat(statistiqueData).then((result) {
        print("Suggestion ajouter");
        // analyse de donnee avec firebase analitique
      }).catchError((e) => print(e));
      // print("Suggestion ajouter $_sender");

      formKey.currentState.reset();

      analytics.logEvent(name: "new statistiques");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistiques"),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Merci d'entrer les données statistiques sur la MVE selon les milieux touchés",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (value) => _milieu = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,

                        decoration: InputDecoration(
                            labelText: "Milieu",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _detail = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                            labelText: "Détails du milieu",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _suspect = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Suspects",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),
                      SizedBox(height: 24.0,),
                      TextFormField(
                        onSaved: (value) => _probable = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Probables",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),

                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _confirmer = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Confirmés",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _gueri = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Guéris",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _deceder = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Decedés",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        onSaved: (value) => _vacciner = value,
                        validator: (value) =>
                        value.isEmpty
                            ? ' error cette zone ne doit pas etre vide'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Nombre de cas Vacinés",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),),),
                      ),
                      SizedBox(height: 24.0,),
                      RaisedButton(

                        shape: StadiumBorder(),
                        splashColor: Colors.deepOrange,
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Text(
                            "Soumettre",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        onPressed: onSendMessage,


                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
