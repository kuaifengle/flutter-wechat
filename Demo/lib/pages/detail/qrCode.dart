import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/appBar.dart';

class QrCodePage extends StatefulWidget {
  QrCodePage({Key key, this.detail}) : super(key: key);
  final Map detail;

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, '二维码名片'),
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(140)),
                width: ScreenUtil().setWidth(140),
                height: ScreenUtil().setWidth(140),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/header.png'),
                        fit: BoxFit.fill),
                    border: Border.all(
                        width: ScreenUtil().setWidth(4), color: Colors.black54),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(140)))),
            Text(
              'kuaifengle',
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: ScreenUtil().setSp(38),
                  height: 2),
            ),
            Container(
              child: Center(
                child: QrImage(
                  padding: EdgeInsets.all(20),
                  data: "https://u.wechat.com/EEmu7ly3pHxjAFHHL5up2fM",
                  // version: QrVersions.auto,
                  size: ScreenUtil().setWidth(500),
                ),
              ),
            )
          ],
        ));
  }
}
