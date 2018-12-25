import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp>{

  var userNameController = new TextEditingController();
  var passWordController = new TextEditingController();
  var passWordController2 = new TextEditingController();

  var fsNode1 = new FocusNode();
  var fsNode2 = new FocusNode();
  var fsNode3 = new FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: new Color(0xFFf9f9f9),
        leading: new IconButton(
          icon: new Icon(Icons.keyboard_arrow_left), color: Color(0xFF555555),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        title: new Text(
          'SignUp', 
          style: new TextStyle(
            color: const Color(0xFF555555)
          ),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Center(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 240.0,
              child: new Image.asset('assets/images/logo.png'),
            ),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: new TextField(
              focusNode: fsNode1,
              controller: userNameController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.person_outline, size: 35.0, color: Color(0xFF393939)),
                hintText: 'UserName'
              ),
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(fsNode2);
              },
            ),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 30.0),
            child: new TextField(
              focusNode: fsNode2,
              keyboardType: TextInputType.text,
              controller: passWordController,
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.lock_outline, size: 35.0, color: Color(0xFF393939)),
                hintText: 'PassWord'
              ),
              obscureText: true,
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(fsNode3);
              },
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top:20.0, bottom: 50.0),
            padding: new EdgeInsets.symmetric(horizontal: 30.0),
            child: new TextField(
              focusNode: fsNode3,
              keyboardType: TextInputType.text,
              controller: passWordController2,
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.lock, size: 35.0, color: Color(0xFF393939)),
                hintText: 'ReportPassWord'
              ),
              obscureText: true,
              onEditingComplete: (){
                fsNode3.unfocus();
              },
            ),
          ),
          new Container(
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
              child: new Text('SIGNUP', style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              ),
              onPressed: () {
                print(userNameController.text);
                if (userNameController.text != '' && (passWordController.text == passWordController2.text && passWordController.text != '' && passWordController2.text != '')) {
                  showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                      title: new Text('提示'),
                      content: new Text('WelCome To WeChat...'),
                      actions: <Widget>[
                        new FlatButton(
                          child:new Text("SignIn"),
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/signIn');
                          },
                        )
                      ],
                    )
                  );
                } else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        title: new Text('提示'),
                        content: new Text('注册信息有误,请检查...'),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('back'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }
                  );
                }
              },
            ),
          ),
        ],
      )
    );
  }
}