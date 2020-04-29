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
        backgroundColor: Color(0xFFf1f1f1),
        appBar: setCustomAppBar(context, '二维码名片'),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
          child: Column(
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
                          width: ScreenUtil().setWidth(4),
                          color: Colors.black54),
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
              ),
              GestureDetector(
                child: Container(
                    width: ScreenUtil().setWidth(450),
                    height: ScreenUtil().setHeight(100),
                    decoration: BoxDecoration(
                        color: Color(0xFF65c324),
                        border: Border.all(
                            width: ScreenUtil().setHeight(1),
                            color: Theme.of(context).primaryColor),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(50))),
                    child: Center(
                      child: Text(
                        '点击保存',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil.getInstance().setSp(30)),
                      ),
                    )),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
