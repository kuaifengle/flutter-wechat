import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../components/toast.dart';
import '../../components/appBar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var userNameController = TextEditingController();
  var passWordController = TextEditingController();
  var passWordController2 = TextEditingController();

  var userNameFN = FocusNode();
  var passWordFN = FocusNode();
  var repeatPassFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    userNameController?.dispose();
    passWordController?.dispose();
    passWordController2?.dispose();
    userNameFN?.dispose();
    passWordFN?.dispose();
    repeatPassFN?.dispose();
  }

  void changePassWord() {
    print(userNameController.text);
    if (userNameController.text != '' &&
        (passWordController.text == passWordController2.text &&
            passWordController.text != '' &&
            passWordController2.text != '')) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('提示'),
                content: Text('WelCome To WeChat...'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("SignIn"),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signIn');
                    },
                  )
                ],
              ));
    } else {
      Toast.show('注册信息有误,请检查...', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, 'SignUp'),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(120),
              ),
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(160),
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: ScreenUtil().setHeight(2),
                          color: Color(0xFFebebeb)))),
              child: TextField(
                focusNode: userNameFN,
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFFc4c4c4),
                      fontSize: ScreenUtil.getInstance().setSp(26),
                    ),
                    border: InputBorder.none,
                    icon: Icon(Feather.user,
                        size: ScreenUtil().setWidth(50),
                        color: Color(0xFF3d3d3d)),
                    hintText: 'UserName'),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(passWordFN);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(30),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: ScreenUtil().setHeight(2),
                          color: Color(0xFFebebeb)))),
              child: TextField(
                focusNode: passWordFN,
                controller: passWordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFFc4c4c4),
                      fontSize: ScreenUtil.getInstance().setSp(26),
                    ),
                    border: InputBorder.none,
                    icon: Icon(Feather.unlock,
                        size: ScreenUtil().setWidth(50),
                        color: Color(0xFF3d3d3d)),
                    hintText: 'PassWord'),
                obscureText: true,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(repeatPassFN);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: ScreenUtil().setHeight(2),
                          color: Color(0xFFebebeb)))),
              child: TextField(
                focusNode: repeatPassFN,
                controller: passWordController2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFFc4c4c4),
                      fontSize: ScreenUtil.getInstance().setSp(26),
                    ),
                    border: InputBorder.none,
                    icon: Icon(Feather.lock,
                        size: ScreenUtil().setWidth(50),
                        color: Color(0xFF3d3d3d)),
                    hintText: 'ReportPassWord'),
                obscureText: true,
                onEditingComplete: () {
                  repeatPassFN.unfocus();
                },
              ),
            ),
            GestureDetector(
              child: Container(
                  width: ScreenUtil().setWidth(380),
                  height: ScreenUtil().setHeight(100),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                  decoration: BoxDecoration(
                      color: Color(0xFF64c223),
                      border: Border.all(
                          width: ScreenUtil().setHeight(2),
                          color: Color(0xFF28b506)),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setHeight(50))),
                  child: Center(
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil.getInstance().setSp(30)),
                    ),
                  )),
              onTap: () {
                changePassWord();
              },
            ),
          ],
        ));
  }
}
