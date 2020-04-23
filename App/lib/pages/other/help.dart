import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';

import '../../components/appbar.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(
          context,
          '帮助与反馈',
        ),
        body: Container(
          child: EasyWebView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              src:
                  'https://kf.qq.com/touch/product/wechat_app.html?scene_id=kf338'),
        ));
  }
}
