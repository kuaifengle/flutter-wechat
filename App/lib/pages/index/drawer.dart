import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../main.dart';
import '../contacts/detailed.dart';
import './contacts.dart';
import '../../common/index.dart';
import '../dynamic/timeLine.dart';

class IndexDrawer extends StatefulWidget {
  IndexDrawer({Key key}) : super(key: key);

  @override
  IndexDrawerState createState() => IndexDrawerState();
}

class IndexDrawerState extends State<IndexDrawer> {
  List<Map<String, dynamic>> drawerList = [
    {'icon': Feather.send, 'title': 'WeChat', 'onTap': (context) {}},
    {
      'icon': Feather.users,
      'title': '联系人',
      'onTap': (context) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ContactsPage();
        })).then((oldValue) {
          CommonState.selectDrawerIndex = 0;
        });
      }
    },
    {
      'icon': Feather.smile,
      'title': '朋友圈',
      'onTap': (context) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TimeLine();
        })).then((oldValue) {
          CommonState.selectDrawerIndex = 0;
        });
      }
    },
    {'icon': Feather.star, 'title': '收藏'},
    {'icon': Feather.settings, 'title': '设置'},
    {
      'icon': Feather.x_octagon,
      'title': '退出登录',
      'onTap': (context) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('提示'),
                  content: Text('你确定要退出吗?'),
                  actions: <Widget>[
                    OutlineButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    OutlineButton(
                      child: Text('确定'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        navigatorKey.currentState
                            .pushReplacementNamed('/signIn');
                        // Navigator.of(CommonState.globalContext)
                        //     .pushReplacementNamed('/signIn');
                      },
                    )
                  ],
                ));
      }
    }
  ];

  List<Widget> returnDrawerList() {
    List<Widget> widgetList = [];

    for (int i = 0; i < drawerList.length; i++) {
      Color color =
          CommonState.selectDrawerIndex == i ? Color(0xFF66c627) : Colors.white;
      Map item = drawerList[i];
      widgetList.add(ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        leading: Icon(item['icon'], color: color),
        title: Text(
          '${item['title']}',
          style: TextStyle(fontSize: ScreenUtil().setSp(24), color: color),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: color,
          size: ScreenUtil().setWidth(40),
        ),
        onTap: () {
          setState(() {
            CommonState.selectDrawerIndex = i;
          });
          Navigator.of(context).pop();
          item['onTap'](context);
        },
      ));
    }
    return widgetList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF242329),
        child: ListView(
          children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(400),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/background.jpg'),
                                  fit: BoxFit.fill)),
                        )),
                    Positioned(
                        width: ScreenUtil().setWidth(634),
                        height: ScreenUtil().setHeight(400),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(60),
                          ),
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    width: ScreenUtil().setWidth(140),
                                    height: ScreenUtil().setWidth(140),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('images/header.png'),
                                            fit: BoxFit.fill),
                                        border: Border.all(
                                            width: ScreenUtil().setWidth(4),
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(140)))),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return Detailed();
                                  }));
                                },
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'kuaifengle',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(34),
                                            height: 1.5),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            '如果我是Dj你会爱我吗?如果我是Dj你会爱我吗?如果我是Dj你会爱我吗?如果我是Dj你会爱我吗?如果我是Dj你会爱我吗?',
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xFFf5f5f5),
                                              fontSize: ScreenUtil().setSp(24),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          ]..addAll(returnDrawerList()),
        ),
      ),
    );
  }
}
