import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/appbar.dart';
import '../../components/dialog.dart';
import '../other/webView.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(
          context,
          '关于微信',
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(140),
                bottom: ScreenUtil().setHeight(40),
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
                    Text('Version 0.0.1',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: ScreenUtil.getInstance().setSp(26),
                        )),
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '功能介绍',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return WebViewPage(
                      title: '功能介绍',
                      webUrl:
                          'https://kf.qq.com/touch/product/wechataq_mp.html?scene_id=kf188');
                }));
              },
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '投诉',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return WebViewPage(
                      title: '投诉',
                      webUrl:
                          'https://mp.weixin.qq.com/s/VDVkmf9VPyZp5fxbVgCB2g');
                }));
              },
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              title: Text(
                '检查更新',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24), color: Color(0xFF333333)),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF333333),
                size: ScreenUtil().setWidth(40),
              ),
              onTap: () {
                UtilDialog.showMessage(context, '当前已是最新版本');
              },
            ),
          ],
        ));
  }
}
