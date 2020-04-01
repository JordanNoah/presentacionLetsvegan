import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;



class SingupForm extends StatefulWidget {
  final String email;
  SingupForm({Key key, this.email}) : super(key: key);

  @override
  _SingupFormState createState() => _SingupFormState(email);

}

class _SingupFormState extends State<SingupForm> {
//imagen
  Future<File> file;
  String statusImage='';
  String base64Image='';
  File tmpFile;
//
  String email;

  _SingupFormState(String emailInfo){
    this.email = emailInfo;
  }

  /////BOTONES DE CONTINUAR
  final GlobalKey<FormState> _passwordUser = new GlobalKey();
  bool _datosUsuariosDisabled;
  bool _ageUp;
  bool _generoPreferenciaDisabled;
  bool _queBusco;
  bool _dieta;
  bool _validatePassword;
  ///
  
  ///Textfields
  ///datos Usuarios
  String _nombres;
  String _apellidos;
  ///fecha nacimiento
  String _dateTime;
  ///generoPreferencia
  String _iam;
  String _iLike;
  ///whatmLooking
  String _whatmLooking;
  ///dieta/estilo de vida
  String _dietaEstilo;
  ///password
  String _password;
  ///upload end point
  static final String uploadEndPoint = "http://192.168.100.54:3002/api/signup";
  ///
  @override
  void initState() { 
    print(this.email);
    super.initState();
    _datosUsuariosDisabled = true;
    _ageUp = true;
    _generoPreferenciaDisabled = true;
    _queBusco = true;
    _dieta = true;
    _validatePassword = false;
    //textfields
    //datos Usuarios
    _nombres="";
    _apellidos="";
    //Fecha nacimiento
    //generoPreferencia?
    _iam="";
    _iLike="";
    //_whatmLooking
    _whatmLooking="";
    //_dietaEstilo;
    _dietaEstilo="";
    //password
    _password="";
  }
  //funciones y metodos de validacion
  _datosUsuarios(){
    print(_nombres);
    print(_apellidos);
    if(_nombres.length!=0 && _apellidos.length!=0){
      _datosUsuariosDisabled = false;
    }
    if(_nombres.length==0 && _apellidos.length==0){
      _datosUsuariosDisabled = true;
    }
  }
  //
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    if(age<18){ _ageUp=true; }
    if(age>=18){ _ageUp=false; }
  }
  _generoPreferencia(){
    if(_iam.length>0 && _iLike.length>0){_generoPreferenciaDisabled=false;}
    if(_iam.length==0 && _iLike.length==0){_generoPreferenciaDisabled=true;}
  }
  _whatmLookingCheck(){
    if(_whatmLooking.length>0){_queBusco=false;}
    if(_whatmLooking.length==0){_queBusco=true;}
  }
  _dietaEstiloCheck(){
    if(_dietaEstilo.length>0){_dieta=false;}
    if(_dietaEstilo.length==0){_dieta=true;}
  }
  //
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  static int totalPages = 7;
  int totalDone = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StepProgressIndicator(
                  totalSteps: totalPages,
                  currentStep: totalDone + 1,
                  size: 7,
                  padding: 0,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.transparent,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 30,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index){},
                    controller:pageController,
                    children: <Widget>[
                      datosUsuario(context),
                      dateBorn(context),
                      generoPreferencia(context),
                      whatmLooking(context),
                      picturePreference(context),
                      stadoComida(context),
                      savePassword(context)
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }

  Widget datosUsuario(context){
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Center(
                child: Text("¿Como te llamas?",style: TextStyle(color: Colors.purple,fontSize: 30.0,fontWeight: FontWeight.bold),),
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.604,
              width: MediaQuery.of(context).size.width - 100,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val){setState(() {
                        _nombres = val;
                      });_datosUsuarios();},
                      decoration: InputDecoration(
                        labelText: "Nombres",
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    TextFormField(
                      onChanged: (val){setState(() {
                        _apellidos = val;
                      });_datosUsuarios();},
                      decoration: InputDecoration(
                        labelText: "Apellidos",
                      ),
                    ),
                  ],
                ),
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: _datosUsuariosDisabled ? Colors.grey : Colors.greenAccent,
                    onPressed: (){_datosUsuariosDisabled ? null :pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut) ;},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

  Widget dateBorn(context){
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Center(
                child: Text("¡Hola USUARIO!¿Cual es tu fecha de nacimiento?",textAlign: TextAlign.center,style: TextStyle(color: Colors.purple,fontSize: 25.0,fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.604,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_dateTime == null ? "Escoja su fecha de nacimiento " : _dateTime.toString()),
                    RaisedButton(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Icon(Icons.calendar_today),
                      onPressed: (){
                        CupertinoRoundedDatePicker.show(
                          context,
                          fontFamily: "Mali",
                          textColor: Colors.white,
                          background: Colors.red[300],
                          borderRadius: 16,
                          initialDatePickerMode: CupertinoDatePickerMode.date,
                          minimumYear: 1900,
                          onDateTimeChanged: (newDateTime) {
                            calculateAge(newDateTime);
                            var formatter = new DateFormat('dd/MM/yyyy');
                            String formatted = formatter.format(newDateTime);
                            setState(() {
                              _dateTime = formatted;
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: _ageUp ? Colors.grey : Colors.greenAccent,
                    onPressed: (){_ageUp?null:pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget generoPreferencia(context){
    return Container(
      color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.803,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("¿Soy?",style: TextStyle(color: Colors.purple,fontSize: 30.0,fontWeight: FontWeight.bold),),
                            Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  color: _iam=="m"?Colors.grey:Colors.white,
                                  onPressed: (){setState(() {_iam="m";});print(_iam);_generoPreferencia();},
                                  child: Text("Chico"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  ),
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  color: _iam=="f"?Colors.grey:Colors.white,
                                  onPressed: (){setState(() {_iam="f";});print(_iam);_generoPreferencia();},
                                  child: Text("Chica"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("¿Busco?",style: TextStyle(color: Colors.purple,fontSize: 30.0,fontWeight: FontWeight.bold),),
                            Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  color: _iLike=="m"?Colors.grey:Colors.white,
                                  onPressed: (){setState(() {_iLike="m";});_generoPreferencia();},
                                  child: Text("Chico"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  ),
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  color: _iLike=="f"?Colors.grey:Colors.white,
                                  onPressed: (){setState(() {_iLike="f";});_generoPreferencia();},
                                  child: Text("Chica"),
                                ),
                                RaisedButton(
                                padding: EdgeInsets.all(15.0),
                                color: _iLike=="b"?Colors.grey:Colors.white,
                                onPressed: (){setState(() {_iLike="b";});_generoPreferencia();},
                                child: Text("Ambos"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: _generoPreferenciaDisabled?Colors.grey:Colors.greenAccent,
                    onPressed: (){_generoPreferenciaDisabled?null:pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget whatmLooking(context){
    return Container(
      child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.803,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("¿Que es lo que estas buscando?",textAlign: TextAlign.center, style: TextStyle(color: Colors.purple,fontSize: 30.0,fontWeight: FontWeight.bold),),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 90,
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            color: _whatmLooking=="n" ? Colors.grey : Colors.white,
                            onPressed: (){setState(() {
                              _whatmLooking="n";
                            });_whatmLookingCheck();},
                            child: Text("Nada en concreto"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 90,
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            color: _whatmLooking=="s" ? Colors.grey : Colors.white,
                            onPressed: (){setState(() {
                              _whatmLooking="s";
                            });_whatmLookingCheck();},
                            child: Text("Sólo chatear"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 90,
                          child:RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            color: _whatmLooking=="as" ? Colors.grey : Colors.white,
                            onPressed: (){setState(() {_whatmLooking="as";});_whatmLookingCheck();},
                            child: Text("Algo serio"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 90,
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            color: _whatmLooking=="ac" ? Colors.grey : Colors.white,
                            onPressed: (){setState(() {
                              _whatmLooking="ac";
                            });_whatmLookingCheck();},
                            child: Text("Algo casual"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: _queBusco?Colors.grey:Colors.greenAccent,
                    onPressed: (){_queBusco?null:pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }



startUpload(){}

  Widget picturePreference(context){
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Muestranos una sonrisa\nSube una foto",textAlign: TextAlign.center,style: TextStyle(color: Colors.purple,fontSize: 30.0,fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.604,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width * 0.42,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent
                    ),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Stack(
                    children: <Widget>[
                      FutureBuilder<File>(
                        future: file,
                        builder: (BuildContext context, AsyncSnapshot<File> snapshot){
                          if(snapshot.connectionState == ConnectionState.done && null != snapshot.data){
                            tmpFile = snapshot.data;
                            base64Image = base64Encode(snapshot.data.readAsBytesSync());
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.transparent
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: FileImage(
                                          snapshot.data
                                        ),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      color: Colors.transparent,
                                      width: 40,
                                      child: ButtonTheme(
                                        minWidth: 10,
                                        child: RaisedButton(
                                          color: Color.fromRGBO(166, 28, 137, 0.65),
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: (){
                                            setState(() {
                                              file = ImagePicker.pickImage(source: ImageSource.gallery);
                                            });
                                          },
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0)
                                          ),
                                          child: Icon(Icons.camera,color: Colors.white,)
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            );
                          }else if (null != snapshot.error){
                            return Text(
                              "Error picking image",
                              textAlign: TextAlign.center,
                            );
                          }else{
                            return Container(
                              child: RaisedButton(
                                color: Color.fromRGBO(166,28,137,0.40),
                                elevation: 0,
                                onPressed: (){
                                  setState(() {
                                    file = ImagePicker.pickImage(source: ImageSource.gallery);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: FaIcon(FontAwesomeIcons.cameraRetro,color: Colors.white),
                                  ),
                                  Align(
                                    alignment: Alignment(0.0,0.50),
                                    child: Text("Escoger una foto",style: TextStyle(color: Colors.white),),
                                  )
                                ],
                              ),
                              )
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        color: Colors.transparent,
                        onPressed: (){pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                        elevation: 0,
                        child: Text("Omitir", style: TextStyle(color: Colors.grey,fontSize: 20.0),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        color: Colors.greenAccent,
                        onPressed: (){pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                        elevation: 0,
                        child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),  
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                )
              ),
            )
          ],
        )
      ),
    );
  }

  Widget stadoComida(context){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Center(
                child: Text("Dieta / Estilo de vida",textAlign: TextAlign.center,style: TextStyle(color: Colors.purple,fontSize: 25.0,fontWeight: FontWeight.bold),),
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.604,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 90,
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      color: _dietaEstilo=="Et"?Colors.grey:Colors.white,
                      onPressed: (){setState(() {
                        _dietaEstilo = "Et";
                      });_dietaEstiloCheck();},
                      child: Text("En transición"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 90,
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      color: _dietaEstilo=="vegan"?Colors.grey:Colors.white,
                      onPressed: (){setState(() {
                        _dietaEstilo = "vegan";
                      });_dietaEstiloCheck();},
                      child: Text("Vegano"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 90,
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      color: _dietaEstilo=="vegetarian"?Colors.grey:Colors.white,
                      onPressed: (){setState(() {
                        _dietaEstilo="vegetarian";
                      });_dietaEstiloCheck();},
                      child: Text("Vegetariano"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: _dieta?Colors.grey:Colors.greenAccent,
                    onPressed: (){_dieta?null:pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget savePassword(context){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Center(
                child: Text("¡Ya es el ultimo paso!\n Danos una contraseña",textAlign: TextAlign.center,style: TextStyle(color: Colors.purple,fontSize: 25.0,fontWeight: FontWeight.bold),),
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.604,
              width: MediaQuery.of(context).size.width - 100,
              child: Form(
                key: _passwordUser,
                autovalidate: _validatePassword,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value){
                        if(value.length<8){return "La contraseña debe poseer mas de 8 caracteres";}else{return null;}
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Contraseña"
                      ),
                      onChanged: (val){
                        setState(() {
                          _password=val;
                        });
                      },
                    ),
                    SizedBox(height: 60.0,),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Repita la contraseña"
                      ),
                      validator: (value){
                        if(value!=_password){
                          return "Las contraseñas no coinciden";
                        }else{null;}
                      },
                    ),
                  ],
                ),
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.greenAccent,
                    onPressed: (){_sendToServer();},
                    elevation: 0,
                    child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _sendToServer(){
    if(_passwordUser.currentState.validate()){
      _prepareToServer();
    }else{
      setState(() {
        _validatePassword=true;
      });
    }
  }
  _prepareToServer(){
    http.post(uploadEndPoint,body: {
      "names": this._nombres,
      "lasts_names":this._apellidos,
      "bornDate":this._dateTime,
      "gender":this._iam,
      "interested_in":this._iLike,
      "looking_for":this._whatmLooking,
      "lifeStyle":this._dietaEstilo,
      "password":this._password,
      "email":this.email,
      "profile_picture":this.base64Image
    }).then((result){
      print(result);
    }).catchError((error){
      print(error);
    });
  }
}