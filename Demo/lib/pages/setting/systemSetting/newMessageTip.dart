import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/appBar.dart';

class NewMessageTip extends StatefulWidget {
  NewMessageTip({Key key, this.detail}) : super(key: key);
  final Map detail;

  @override
  _NewMessageTipState createState() => _NewMessageTipState();
}

class _NewMessageTipState extends State<NewMessageTip> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '信息消息提示'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '接受新消息通知',
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
                '接受语音和视频通话邀请通知',
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
                '通知显示消息详情',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              subtitle: Text(
                '关闭后,当微信收到消息时,通知提示将不显示发信人和内容',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16), color: Color(0xFFcccccc)),
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
                '新消息系统通知',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              subtitle: Text(
                '前往系统设置中修改声音与振动',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16), color: Color(0xFFcccccc)),
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
                '语音和视频通话邀请',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              subtitle: Text(
                '收到语音和视频通话邀请的声音与振动',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16), color: Color(0xFFcccccc)),
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
                '聊天界面的新消息通知',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              subtitle: Text(
                '位于聊天界面的新消息通知的声音与振动',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16), color: Color(0xFFcccccc)),
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
