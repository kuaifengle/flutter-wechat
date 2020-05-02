import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';

import '../../components/appbar.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key, this.title, this.webUrl}) : super(key: key);
  final String title;

  final String webUrl;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(
          context,
          widget.title,
        ),
        body: Container(
          child: EasyWebView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              src: widget.webUrl),
        ));
  }
}
