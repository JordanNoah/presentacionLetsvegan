import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presentacion/src/singupForm.dart';
import 'package:http/http.dart' as http;

class Singup extends StatefulWidget {
  Singup({Key key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final GlobalKey<FormState> _emailUser = new GlobalKey();
  final GlobalKey<ScaffoldState> _snackBarKey = new GlobalKey();
  bool _validateEmail = false;
  String email;
  _showSnackBar(){
    var snackBar = SnackBar(
      content: Text("Este email ya se encuentra registrado"),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 1200),
    );
    _snackBarKey.currentState.showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _snackBarKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black87,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/mainlogo.png"),
                                fit: BoxFit.contain
                              )
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: "Let's vegan",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30)),
                                ]
                              )
                            ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Form(
                            key: _emailUser,
                            child: TextFormField(
                              validator: validateMail,
                              onSaved: (String val){email=val;},
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.mail_outline) ,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                labelText: 'Email',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          )
                        ),
                      )
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){Navigator.pushNamed(context, "login");},
                          child: Text("¿Ya tienes cuenta? Ven e inicia sesion", style: TextStyle(color: Colors.white),),
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 50,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            color: Colors.green,
                            onPressed: (){_checkFirst();},
                            child: Text("Empezar creación!",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _checkFirst(){
    if(_emailUser.currentState.validate()){
      _emailUser.currentState.save();
      _prepareToServer();
    }else{
      setState(() {
        _validateEmail = true;
      });
    }
  }

  String validateMail(String value){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(value.length==0){
      return "Email es requerido para empezar la cuenta";
    }else if(!regex.hasMatch(value)){
      return "Ingrese un email valido";
    }else{
      return null;
    }
  }

  _prepareToServer(){
    http.post("http://192.168.100.54:3002/api/checkMail",body: {
      "email":this.email
    }).then((result){
      var resultDecode = jsonDecode(result.body);
      if(resultDecode["status"]=="fail"){
        _showSnackBar();
      }
      if(resultDecode["status"]=="success"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SingupForm(email: this.email,)));
      }
    }).catchError((error){
      print(error);
    });
  }
}