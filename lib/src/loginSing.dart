import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class LoginSing extends StatefulWidget {
  LoginSing({Key key}) : super(key: key);

  @override
  _LoginSingState createState() => _LoginSingState();
}

class _LoginSingState extends State<LoginSing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CarouselSlider(
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            viewportFraction: 1.0,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            items: [1,2,3].map((i){
              return Builder(
                builder: (BuildContext context){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.greenAccent,
                    child: Image.asset("assets/images/login$i.jpg",fit: BoxFit.cover,)
                  );
                },
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Let's",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontStyle: FontStyle.normal,decoration: TextDecoration.none)),
                      TextSpan(text: " Vegan",style: TextStyle(fontStyle: FontStyle.normal,decoration: TextDecoration.none,color: Colors.white,fontWeight: FontWeight.normal))
                    ]
                  ),
                ),
                ),
                SizedBox(height: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Obten la mejor experiencia en let's vegan",style: TextStyle(color: Colors.white60),),
                    SizedBox(height: 20.0,),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      child: RaisedButton(
                        padding: EdgeInsets.only(top:15,bottom:15),
                        color: Colors.transparent,
                        onPressed: (){Navigator.pushNamed(context, 'singUp');},
                        child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: <Widget>[
                        Expanded(child: Divider(),),
                        Expanded(
                          child: Divider(color: Colors.white,),
                        ),
                        Text("     O     ",style:TextStyle(color: Colors.white),),
                        Expanded(
                          child: Divider(color: Colors.white,),
                        ),
                        Expanded(child: Divider(),),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      child: RaisedButton(
                        padding: EdgeInsets.only(top:15,bottom:15),
                        color: Colors.transparent,
                        onPressed: (){Navigator.pushNamed(context, "login");},
                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}