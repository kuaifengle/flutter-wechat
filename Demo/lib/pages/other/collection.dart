import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/appbar.dart';

class Collection extends StatefulWidget {
  Collection({
    Key key,
  }) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
}

enum CollectionEnums {
  Text,
  Image,
  Link,
  Video,
  File,
  Adress,
  ChatHistory,
  Music
}

Map<CollectionEnums, String> collectionTextMap = {
  CollectionEnums.Text: '笔记',
  CollectionEnums.Image: '图片',
  CollectionEnums.Link: '链接',
  CollectionEnums.Video: '视频',
  CollectionEnums.File: '文件',
  CollectionEnums.Adress: '位置',
  CollectionEnums.ChatHistory: '聊天记录',
  CollectionEnums.Music: '音乐'
};

class _CollectionState extends State<Collection> {
  List<Map<String, dynamic>> _collectMenuList = [
    {"title": "图片与视频"},
    {"title": "链接"},
    {"title": "文件"},
    {"title": "音乐"},
    {"title": "聊天记录"},
    {"title": "语音"},
    {"title": "笔记"},
    {"title": "位置"}
  ];

  List<Map<String, dynamic>> _collectDataList = [
    {
      "content": "你对这个世界微笑,世界就对你微笑!",
      'type': CollectionEnums.Text,
      'user': 'kuaifengle',
      'time': '23天前'
    },
    {
      "content": "你对这个世界微笑,世界就对你微笑!",
      'type': CollectionEnums.Text,
      'user': 'kuaifengle',
      'time': '23天前'
    },
    {
      "content": "你对这个世界微笑,世界就对你微笑!",
      'type': CollectionEnums.Text,
      'user': 'kuaifengle',
      'time': '23天前'
    },
    {
      "content": "你对这个世界微笑,世界就对你微笑!",
      'type': CollectionEnums.Text,
      'user': 'kuaifengle',
      'time': '23天前'
    },
  ];

  /// 返回收藏列表
  _returnCollectList(item) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
      child: Column(
        children: <Widget>[
          Padding(
            child: Row(
              children: <Widget>[Text('${item['content']}')],
            ),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
          ),
          Row(
            children: <Widget>[
              Text(
                '[${collectionTextMap[item['type']]}]   ',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(28)),
              ),
              Text(
                '${item['user']}',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(28)),
              ),
              Text(
                '     -${item['time']}',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(28)),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth =
        (MediaQuery.of(context).size.width - ScreenUtil().setWidth(80)) / 4;
    return Scaffold(
        appBar: setCustomAppBar(context, '我的收藏', actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {},
          // )
        ]),
        backgroundColor: Color(0xFFededed),
        body: ListView(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(20)))),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(30)),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                child: Wrap(
                  runSpacing: ScreenUtil().setHeight(30),
                  children: []..addAll(_collectMenuList.map((item) {
                      return Container(
                        width: itemWidth,
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: BorderDirectional(
                                end: BorderSide(
                              color: (_collectMenuList.indexOf(item) % 4) < 3
                                  ? Colors.black26
                                  : Colors.white,
                              width: 1,
                            ))),
                        child: Text(
                          '${item['title']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: ScreenUtil().setSp(28)),
                        ),
                      );
                    }).toList()),
                ),
              ),
            ]..addAll(_collectDataList.map((item) {
                return _returnCollectList(item);
              }))));
  }
}
