import 'package:flutter/material.dart';
import 'package:flutter_wechat/common/index.dart';
import './index/drawer.dart';
import './index/contactsList.dart';
import '../components/appbar.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: setCustomAppBar(context, 'WeChat',
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(0.0, 60.0),
              icon: Icon(Icons.add),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(child: Text('扫一扫'), value: '1'),
                  PopupMenuItem(child: Text('收付款'), value: '1'),
                  PopupMenuItem(child: Text('帮助与反馈'), value: '1'),
                ];
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          )),
      drawer: IndexDrawer(),
      body: Contacts(),
    );
  }
}
