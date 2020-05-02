import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/appBar.dart';

class CanDisturb extends StatefulWidget {
  CanDisturb({Key key, this.detail}) : super(key: key);
  final Map detail;

  @override
  _CanDisturbState createState() => _CanDisturbState();
}

class _CanDisturbState extends State<CanDisturb> {
  bool switch1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(context, '勿扰模式'),
      body: ListView(
        children: <Widget>[
          ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '勿扰模式',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              subtitle: Text(
                '开启后,在设定时间段收到新消息时不会响铃或震动',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16), color: Color(0xFFcccccc)),
              ),
              trailing: Switch(
                  value: switch1,
                  onChanged: (value) {
                    setState(() {
                      switch1 = value;
                    });
                  })),
        ],
      ),
    );
  }
}
