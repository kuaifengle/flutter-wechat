import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/appBar.dart';

class ChatSetting extends StatefulWidget {
  ChatSetting({Key key, this.detail}) : super(key: key);
  final Map detail;

  @override
  _ChatSettingState createState() => _ChatSettingState();
}

class _ChatSettingState extends State<ChatSetting> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '聊天'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '使用听筒播放声音',
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
                '使用回车键发送消息',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Switch(
                  value: switch2,
                  onChanged: (value) {
                    setState(() {
                      switch2 = value;
                    });
                  })),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '聊天背景',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {}),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '表情管理',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {}),
          Container(
              height: ScreenUtil().setHeight(20), color: Color(0xFFededed)),
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '聊天记录备份与迁移',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {}),
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
              onTap: () {}),
        ],
      ),
    );
  }
}
