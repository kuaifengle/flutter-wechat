import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signUp.dart';
import 'dart:convert';

class SignIn extends StatefulWidget{
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{

  var userNameController = new TextEditingController();
  var passWordController = new TextEditingController();

  var fsNode1 = new FocusNode();
  var fsNode2 = new FocusNode();

  Animation animationLogo;
  Animation animationUser;
  Animation animationPass;
  Animation animationBtn;
  AnimationController controller;

  @override
    void initState() {
      controller = new AnimationController(duration: new Duration(seconds: 1), vsync: this);
      animationLogo = new Tween(begin: -1.0, end: 0.0).animate(new CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn
      ));
      animationUser = new Tween(begin: -1.0, end: 0.0).animate(new CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 1,  curve: Curves.fastOutSlowIn)
      ));
      animationPass = new Tween(begin: -1.0, end: 0.0).animate(new CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 1,  curve: Curves.fastOutSlowIn)
      ));
      animationBtn = new Tween(begin: -1.0, end: 0.0).animate(new CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 1,  curve: Curves.fastOutSlowIn)
      ));

      controller.forward();
      super.initState();
    }

  @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    return  new AnimatedBuilder(
        animation: animationLogo,
        builder: (BuildContext context, child){
        return new Scaffold(
            body: new ListView(
              children: <Widget>[
                new Transform(
                  transform: Matrix4.translationValues(width * animationLogo.value, 0, 0),
                  child: new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 260.0,
                      child: new Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                new Transform(
                    transform: Matrix4.translationValues(width * animationUser.value, 0, 0),
                    child: new Container(
                        padding: new EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                        child: new TextField(
                          focusNode: fsNode1,
                          keyboardType: TextInputType.text,
                          controller: userNameController,
                          decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.person_outline, size: 35.0, color: Color(0xFF393939)),
                        hintText: 'UserName'
                      ),
                      onEditingComplete: (){
                        FocusScope.of(context).requestFocus(fsNode2);
                      },
                    ),
                  ),
                ),
                new Transform(
                  transform: Matrix4.translationValues(width * animationPass.value, 0, 0),
                  child: new Container(
                  margin: new EdgeInsets.only(bottom: 50.0),
                  padding: new EdgeInsets.symmetric(horizontal: 30.0),
                  child: new TextField(
                    focusNode: fsNode2,
                    controller: passWordController,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.lock_outline, size: 35.0, color: Color(0xFF393939)),
                      hintText: 'PassWord'
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              new Transform(
                transform: Matrix4.translationValues(width * animationBtn.value, 0, 0),
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: new RaisedButton(
                    padding: new EdgeInsets.symmetric(vertical: 15.0),
                    color: const Color(0xFF64c223),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    child: new Text('LOGIN', style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                      ),
                    ),
                    onPressed: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var userInfo = {
                        'name': 'kuaifengle',
                        'id': 1,
                        'checkInfo': 'https://github.com/kuaifengle',
                        'lastTime': '20.11',
                        'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
                        'backgroundUrl': 'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
                      };

                      prefs.setString('userInfo', json.encode(userInfo));
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ),
              ),
              new Transform(
                transform: Matrix4.translationValues(width * animationBtn.value, 0, 0),
                child: new Container(
                  margin: new EdgeInsets.only(left: 150.0, right:150.0, top: 80.0),
                  child: new OutlineButton(
                    borderSide: new BorderSide(color: Color(0xFFbcbcbc)),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    child: new Text('SIGNUP', style: new TextStyle(
                        color: Color(0xFFbcbcbc),
                        fontSize: 12.0
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (_) => new SignUp() 
                        )
                      );
                    },
                  ),
                )
              )
            ],
          )
        );
      },
    );
  }
}