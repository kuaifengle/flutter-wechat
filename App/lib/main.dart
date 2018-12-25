import 'package:flutter/material.dart';

import './pages/home/home.dart';
import './pages/home/fistPage.dart';
import './pages/sign/signIn.dart';

main(){
  return runApp(new MyWeChat());
}

class MyWeChat extends StatefulWidget{
  @override

  _MyWeChatState createState() => new _MyWeChatState();
}

class _MyWeChatState extends State<MyWeChat>{
  @override

  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Flutter仿微信',
      theme: new ThemeData(
        primaryColorBrightness: Brightness.dark,
        primaryColor: const Color(0xFF64c223),
        hintColor: const Color(0xFFcfcfcf),
        iconTheme: new IconThemeData(
          color: Colors.white
        ),
      ),
      home: new FirstPage(),
      routes: <String, WidgetBuilder>{
        '/home': (_) => new Home(),
        '/signIn': (_) => new SignIn()
      }
    );
  }
}