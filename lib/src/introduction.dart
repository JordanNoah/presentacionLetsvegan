import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Introduction extends StatefulWidget {
  Introduction({Key key}) : super(key: key);

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LiquidSwipe(
        enableLoop: false,
        initialPage: 0,
        enableSlideIcon:true,
        pages: <Container>[
          primerPage(),
          segundaPage(),
          tercerPage(),
          cuartaPage()
        ],
      ),
    );
  }
  Widget primerPage(){
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              onPressed: (){Navigator.pushNamed(context, "loginSing");},
              child: Text("Skip"),
            )
          ],
        ),
      ),
    );
  }
  Widget segundaPage(){
    return Container(
      color: Colors.red,
      child: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              onPressed: (){Navigator.pushNamed(context, "loginSing");},
              child: Text("Skip"),
            )
          ],
        ),
      ),
    );
  }
  Widget tercerPage(){
    return Container(
      color: Colors.purple,
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              onPressed: (){Navigator.pushNamed(context, "loginSing");},
              child: Text("Skip"),
            )
          ],
        ),
      ),
    );
  }
  Widget cuartaPage(){
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              onPressed: (){Navigator.pushNamed(context, "loginSing");},
              child: Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}