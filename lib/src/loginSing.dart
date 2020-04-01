import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class LoginSing extends StatefulWidget {
  LoginSing({Key key}) : super(key: key);

  @override
  _LoginSingState createState() => _LoginSingState();
}

class _LoginSingState extends State<LoginSing> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/letsvegvideo.mp4")..initialize().then((_){
      _controller.play();
      _controller.setLooping(true);
      setState(() {});
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Center(
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Obten la mejor experiencia en let's vegan",style: TextStyle(color: Colors.white60),),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 50,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top:15,bottom:15),
                            color: Colors.transparent,
                            elevation: 0,
                            onPressed: (){Navigator.pushNamed(context, 'singUp');},
                            child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
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
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width - 50,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top:15,bottom:15),
                            color: Colors.transparent,
                            elevation: 0,
                            onPressed: (){Navigator.pushNamed(context, "login");},
                            child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}