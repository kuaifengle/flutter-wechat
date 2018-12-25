import 'package:flutter/material.dart';

import '../user/drawer.dart';
import '../user/userList.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home>{
  int _lastClickTime = 0;

  bool btnShow = true;

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: (){
        // 双击退出应用
      int nowTime = new DateTime.now().microsecondsSinceEpoch;
          if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
            return new Future.value(true);
          } else {
            _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
            new Future.delayed(const Duration(milliseconds: 1500), () {
              _lastClickTime = 0;
            });
            return new Future.value(false);
          }
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'WeChat',
            style: new TextStyle(
              color: const Color(0xFFFFFFFF)
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(0.0, 60.0),
              icon: Icon(Icons.add),
              itemBuilder: (_){
                return [
                  new PopupMenuItem(
                    child: new Text('发起群聊'),
                    value: '1'
                  ),
                  new PopupMenuItem(
                    child: new Text('扫一扫'),
                    value: '1'
                  ),
                  new PopupMenuItem(
                    child: new Text('收付款'),
                    value: '1'
                  ),
                  new PopupMenuItem(
                    child: new Text('帮助与反馈'),
                    value: '1'
                  ),
                ];
              },
            )
          ],
        ),
        drawer: new Index_Drawer(),
        body: new UserList(),
      ),
    );
  }
}