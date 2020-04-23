import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:toast/toast.dart';

import './signUp.dart';
import '../../dataJson/userData.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  var userNameController = TextEditingController();
  var passWordController = TextEditingController();

  var userNameFN = FocusNode();
  var passWordFN = FocusNode();

  void login() async {
    String userName = userNameController.text;
    String passWord = passWordController.text;
    if (userName == '') {
      Toast.show('请输入账号名', context);
      return;
    }

    if (passWord == '') {
      Toast.show('请输入密码', context);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userInfo', mySelf.toString());

    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void dispose() {
    super.dispose();
    userNameController?.dispose();
    passWordController?.dispose();
    userNameFN?.dispose();
    passWordFN?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(140),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(160),
                ),
                Text('WeChat(仿)',
                    style: TextStyle(
                      color: Color(0xFFc4c4c4),
                      fontSize: ScreenUtil.getInstance().setSp(50),
                    )),
              ],
            ),
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
            keyboardType: TextInputType.text,
            controller: userNameController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFFc4c4c4),
                  fontSize: ScreenUtil.getInstance().setSp(26),
                ),
                icon: Icon(Feather.user,
                    size: ScreenUtil().setWidth(50), color: Color(0xFF3d3d3d)),
                hintText: 'UserName'),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passWordFN);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: ScreenUtil().setHeight(2),
                      color: Color(0xFFebebeb)))),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              bottom: ScreenUtil().setHeight(120)),
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
                    size: ScreenUtil().setWidth(50), color: Color(0xFF3d3d3d)),
                hintText: 'PassWord'),
            obscureText: true,
          ),
        ),
        GestureDetector(
          child: Container(
              width: ScreenUtil().setWidth(380),
              height: ScreenUtil().setHeight(100),
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(220)),
              decoration: BoxDecoration(
                  color: Color(0xFF65c324),
                  border: Border.all(
                      width: ScreenUtil().setHeight(1),
                      color: Color(0xFF28b506)),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(50))),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil.getInstance().setSp(30)),
                ),
              )),
          onTap: login,
        ),
        Center(
            child: GestureDetector(
          child: Container(
            width: ScreenUtil().setWidth(240),
            height: ScreenUtil().setHeight(60),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: ScreenUtil().setHeight(1), color: Color(0xFFbcbcbc)),
                borderRadius:
                    BorderRadius.circular(ScreenUtil().setHeight(30))),
            child: Text(
              'SIGNUP',
              style: TextStyle(
                  color: Color(0xFFbcbcbc),
                  fontSize: ScreenUtil.getInstance().setSp(22)),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SignUp()));
          },
        ))
      ],
    ));
  }
}
