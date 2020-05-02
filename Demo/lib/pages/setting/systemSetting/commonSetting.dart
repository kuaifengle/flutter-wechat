import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/appBar.dart';

class CommonSetting extends StatefulWidget {
  CommonSetting({Key key, this.detail}) : super(key: key);
  final Map detail;

  @override
  _CommonSettingState createState() => _CommonSettingState();
}

class _CommonSettingState extends State<CommonSetting> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '通用'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '开启横屏模式',
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
                '开启NFC功能',
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
                '自动下载微信安装包',
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
                '多语言',
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
                '字体大小',
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
                '照片/视频和文件',
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
                '发现页管理',
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
                '辅助功能',
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
                '流量统计',
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
                '微信储存空间',
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
