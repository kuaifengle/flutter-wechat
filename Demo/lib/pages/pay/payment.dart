import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/appbar.dart';
import './collectMoney.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: setCustomAppBar(
          context,
          '收付款',
        ),
        body: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          Icons.credit_card,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '向商家付款',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
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
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(20)))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      leading: Icon(Icons.verified_user, color: Colors.white),
                      title: Text(
                        '二维码收款',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return CollectMoneyPage();
                        }));
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      leading: Icon(Icons.control_point_duplicate,
                          color: Colors.white),
                      title: Text(
                        '赞赏码',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      leading: Icon(Icons.supervised_user_circle,
                          color: Colors.white),
                      title: Text(
                        '群收款',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      leading: Icon(Icons.face, color: Colors.white),
                      title: Text(
                        '面对面红包',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      leading: Icon(Icons.atm, color: Colors.white),
                      title: Text(
                        '向银行卡或手机号转账',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.white),
                      ),
                      onTap: () {},
                    )
                  ],
                ))
          ],
        ));
  }
}
