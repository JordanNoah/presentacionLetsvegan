import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colors.black38,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 60.0,),
                  Container(
                    padding: EdgeInsets.only(top:40.0),
                    height: 150.0,
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
                  SizedBox(height: 90.0,),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon:Icon(Icons.mail_outline) ,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                labelText: 'User name / Email',
                                fillColor: Colors.white,
                                filled: true,
                                
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                                ),
                                prefixIcon: Icon(Icons.vpn_key),
                                suffixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                fillColor: Colors.white,
                                filled: true
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 20.0,),
                        GestureDetector(
                          onTap: (){},
                          child: Text("Olvide mi contraseña", style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(height: 15.0,),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 50,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            color: Colors.green,
                            onPressed: (){},
                            child: Text("Iniciar sesión",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        GestureDetector(
                          onTap: (){Navigator.pushNamed(context, "singUp");},
                          child: Text("¿No posees cuenta? Ven y crea una", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}