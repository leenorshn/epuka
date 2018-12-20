import 'package:epuka/services/SuggestionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddSuggestionScreen extends StatefulWidget {
  @override
  _AddSuggestionScreenState createState() => _AddSuggestionScreenState();
}

class _AddSuggestionScreenState extends State<AddSuggestionScreen> {
  final formKey = new GlobalKey<FormState>();

  // TextEditingController editingController=new TextEditingController();

  String _titre;
  String _suggs;
  String _sender;

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
      SuggService suggService = new SuggService();

      Map<String, dynamic> suggData = {
        "titre": _titre,
        "suggestion": _suggs,
        "sender": _sender,
        "timestamp": DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
      };

      suggService.addSugg(suggData).then((result) {
        print("Suggestion ajouter $_sender");
        // analyse de donnee avec firebase analitique
      }).catchError((e) => print(e));
      print("Suggestion ajouter $_sender");

      formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestion / Avis"),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Votre suggestion ou avis sera traité par l'equipe de la lutte contre la Maladie à Virus Ebola",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[

                  /// formulaire de creation d'une suggestion
                  TextFormField(
                    maxLines: 1,
                    onSaved: (value) => _titre = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "titre",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    maxLines: 1,
                    onSaved: (value) => _sender = value,
                    validator: (value) =>
                    value.isEmpty
                        ? ' error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    maxLines: 4,
                    onSaved: (value) => _suggs = value,
                    validator: (value) =>
                    value.isEmpty
                        ? 'error cette zone ne doit pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        labelText: "suggestion",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          RaisedButton(
              shape: StadiumBorder(),
              splashColor: Colors.greenAccent,
              color: Colors.green,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text(
                  "Soumettre",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: validateAndSubmit),
        ],
      ),
    );
  }
}
