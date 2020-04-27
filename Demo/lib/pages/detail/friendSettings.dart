import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../dataJson/userData.dart';
import '../../components/appBar.dart';
import '../../components/searchPage.dart';

class FriendSettings extends StatefulWidget {
  FriendSettings({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _FriendSettingsState createState() => _FriendSettingsState();
}

class _FriendSettingsState extends State<FriendSettings> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '好友设置'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '查找聊天记录',
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
                '设置备注/标签',
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
                '消息免打扰',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Switch(
                  value: switch1,
                  onChanged: (value) {
                    setState(() {
                      switch1 = value;
                    });
                  })),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '置顶聊天',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Switch(
                  value: widget.detail['isTop'],
                  onChanged: (value) {
                    userInfoList.forEach((res) => res['isTop'] = false);
                    userInfoList[userInfoList.indexOf(widget.detail)]['isTop'] =
                        value;
                    setState(() {
                      widget.detail['isTop'] = value;
                    });
                  })),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '强提醒',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Switch(
                  value: switch3,
                  onChanged: (value) {
                    setState(() {
                      switch3 = value;
                    });
                  })),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '设置当前聊天背景',
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
                '清空聊天记录',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {
                Alert(
                  context: context,
                  style: AlertStyle(
                      titleStyle: TextStyle(fontSize: ScreenUtil().setSp(30))),
                  title: "确定要清空聊天记录吗?",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "取消",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(30)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Color(0xFFcccccc),
                    ),
                    DialogButton(
                        child: Text(
                          "确定",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(30)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Theme.of(context).primaryColor)
                  ],
                ).show();
              }),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          GestureDetector(
            child: Container(
                height: ScreenUtil().setHeight(100),
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(50),
                    horizontal: ScreenUtil().setWidth(50)),
                decoration: BoxDecoration(
                    color: Color(0xFFf56c6c),
                    border: Border.all(
                        width: ScreenUtil().setHeight(2),
                        color: Color(0xFFdcdfe6)),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(50))),
                child: Center(
                  child: Text(
                    '删  除',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil.getInstance().setSp(30)),
                  ),
                )),
            onTap: () {
              Alert(
                context: context,
                style: AlertStyle(
                    titleStyle: TextStyle(fontSize: ScreenUtil().setSp(30))),
                title: "确定要删除Ta吗?",
                buttons: [
                  DialogButton(
                    child: Text(
                      "取消",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(30)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Color(0xFFcccccc),
                  ),
                  DialogButton(
                      child: Text(
                        "确定",
                        style: TextStyle(
                            color: Color(0xFFf56c6c),
                            fontSize: ScreenUtil().setSp(30)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        userInfoList.remove(widget.detail);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/home', (_) => false);
                      },
                      color: Theme.of(context).primaryColor)
                ],
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
