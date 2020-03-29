import 'package:flutter/material.dart';
import 'package:presentacion/src/introduction.dart';
import 'package:presentacion/src/login.dart';
import 'package:presentacion/src/loginSing.dart';
import 'package:presentacion/src/singup.dart';
import 'package:presentacion/src/singupForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocina',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(BuildContext context)=>Introduction(),
        "loginSing":(BuildContext context)=>LoginSing(),
        "login":(BuildContext context)=>Login(),
        "singUp":(BuildContext context)=>Singup(),
        "singupForm":(BuildContext context)=>SingupForm()
      },
    );
  }
}