import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../components/appBar.dart';
import '../../components/searchPage.dart';

class UserSetting extends StatefulWidget {
  UserSetting({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '设置'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '账号安全',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              }),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '新消息提示',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '勿扰模式',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '聊天',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '隐私',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '通用',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '关于微信',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              )),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          GestureDetector(
            child: Container(
                height: ScreenUtil().setHeight(100),
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(50),
                    horizontal: ScreenUtil().setWidth(50)),
                decoration: BoxDecoration(
                    color: Color(0xFFdcdfe6),
                    border: Border.all(
                        width: ScreenUtil().setHeight(2),
                        color: Color(0xFFdcdfe6)),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(50))),
                child: Center(
                  child: Text(
                    '切换账号',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil.getInstance().setSp(30)),
                  ),
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('提示'),
                        content: Text('你确定要切换账号吗?'),
                        actions: <Widget>[
                          OutlineButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          OutlineButton(
                            child: Text('确定'),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              navigatorKey.currentState
                                  .pushReplacementNamed('/signIn');
                            },
                          )
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
