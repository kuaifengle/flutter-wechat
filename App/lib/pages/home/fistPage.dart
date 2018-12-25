import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './fistOpen.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage>{

  void initState() {
    start();
    super.initState();
  }

  start() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('firstOpen') == null || prefs.getBool('firstOpen') != true) {
      // 第一次打开App
      prefs.setBool('firstOpen', true);
      Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
              builder: (context) => FirstOpen(),
            ),
            (route) => route == null
      );
      return;
    }
    if (prefs.getString('userInfo') == null) {
      jumpTo('/signIn');
    } else {
      jumpTo('/home');
    }
  }

  void jumpTo(path) {
    var _duration = new Duration(seconds: 2);
    new Future.delayed(_duration,(){
      Navigator.of(context).pushNamedAndRemoveUntil(path, (router) => false);
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new FittedBox(
          child: new Image.asset('assets/images/start.jpg',),
          fit: BoxFit.fill,
        )
      ),
    );
  }
}