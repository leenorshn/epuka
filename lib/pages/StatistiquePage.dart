import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epuka/utils/SmartLoader.dart';
import 'package:flutter/material.dart';

class StatistiquePage extends StatefulWidget {
  @override
  _StatistiquePageState createState() => _StatistiquePageState();
}

class _StatistiquePageState extends State<StatistiquePage> {
  Future _data;

  Future getStatique() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("statistique").getDocuments();

    return qn.documents;
  }

  @override
  void initState() {
    super.initState();

    _data = getStatique();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _data,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SmartLoader());
              } else {
                return ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(children: <Widget>[
                            ListTile(
                              title: Text(
                                snapshot.data[index].data["milieu"],
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                snapshot.data[index].data["detail"],
                                textAlign: TextAlign.justify,
                                style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                              ),
                            ),
                            ExpansionTile(
                              title: const Text(
                                'Voir dernieres statistiques',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              backgroundColor: Colors.grey.withAlpha(100),
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Card(
                                          child: Container(
                                            height: 100.0,
                                            width: 100.0,
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Suspects",
                                                  style: TextStyle(
                                                      color: Colors.amberAccent,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["suspect"]}",
                                                  style: TextStyle(
                                                      color: Colors.amber,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),


                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 100.0,
                                            width: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Probables",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .purpleAccent,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["probable"]}",
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),


                                    Column(
                                      children: <Widget>[
                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 100.0,
                                            width: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Décédés",
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["deceder"]}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),


                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 100.0,
                                            width: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Guéris",
                                                  style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["gueri"]}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 100.0,
                                            width: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Confirmés",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .orangeAccent,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["confirmer"]}",
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            height: 100.0,
                                            width: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(

                                                  "Vaccinés",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  " ${snapshot.data[index]
                                                      .data["vacciner"]}",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text("Cas"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ])
                        //Text(snapshot.data[index].data["milieu"])
                      );
                    });
              }
            }),
      ),

    );
  }
}

/*

*/
