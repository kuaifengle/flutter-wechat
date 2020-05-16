import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/appbar.dart';

class CollectMoneyPage extends StatefulWidget {
  @override
  _CollectMoneyPageState createState() => _CollectMoneyPageState();
}

class _CollectMoneyPageState extends State<CollectMoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE9B548),
        appBar:
            setCustomAppBar(context, '收付款', backgroundColor: Color(0xFFE9B548)),
        body: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(20)))),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFededed),
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(ScreenUtil().setWidth(20)),
                            topLeft:
                                Radius.circular(ScreenUtil().setWidth(20)))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.redo,
                          color: Color(0xFFE9B548),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '二维码付款',
                            style: TextStyle(
                              color: Color(0xFFE9B548),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: QrImage(
                      padding: EdgeInsets.all(20),
                      data: "https://u.wechat.com/EEmu7ly3pHxjAFHHL5up2fM",
                      // version: QrVersions.auto,
                      size: ScreenUtil().setWidth(500),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    leading: Icon(Icons.featured_play_list),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: ScreenUtil().setWidth(40),
                    ),
                    title: Text(
                      '收款小账本',
                      style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
