import 'package:epuka/screens/ModeExpertScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SecretCode extends StatefulWidget {
  @override
  _SecretCodeState createState() => _SecretCodeState();
}

class _SecretCodeState extends State<SecretCode> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  int _secretMot=1234;

  void _validAndSubmit(){
    if( _secretMot==1234){
      Route route=CupertinoPageRoute(builder: (context)=>ExpertScreen());
      Navigator.of(context).pushReplacement(route);
    }else{
      print("mode expert erreur code");
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Code Secret"),
      ),
      body: Center(
        child: Form(
          key: _key,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0,),
               Container(
                 width: 200.0,
                 child: new TextFormField(
                   textAlign: TextAlign.center,
                   obscureText: true,
                   onSaved: (value)=>_secretMot=int.parse(value),
                   decoration: InputDecoration(labelText: "Entez le Code Ici",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(30.0),)),
                   

                 ),
               ),
                RaisedButton(
                    onPressed:_validAndSubmit,
                    child: Text("Valider",style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );



  }

}
