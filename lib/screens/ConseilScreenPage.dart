import 'package:epuka/services/ConseilService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ConseilScreenPage extends StatefulWidget {
  @override
  _ConseilScreenPageState createState() => _ConseilScreenPageState();
}

class _ConseilScreenPageState extends State<ConseilScreenPage> {

  final formKey = GlobalKey<FormState>();
  String _titre;
  String _conseil;

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

  void validateAndSubmit() {
    if (validateAndSave()) {
      ConseilService suggService = new ConseilService();

      Map<String, dynamic> suggData = {
        "titre": _titre,
        "contenu": _conseil,
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
      };

      suggService.addConseil(suggData).then((result) {
        print("Conseil ajouter ");
        // analyse de donnee avec firebase analitique
      }).catchError((e) => print(e));
      //print("Suggestion ajouter $_sender");

      formKey.currentState.reset();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conseil sur la MVE"),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Merci de poster un nouveau conseil sur la MVE",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) => _titre = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "titre conseil",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    onSaved: (value) => _conseil = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "Entrer le conseil ici",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
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
                      onPressed: validateAndSubmit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
