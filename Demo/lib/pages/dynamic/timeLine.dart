import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_wechat/components/button.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../components/button.dart';
import '../../components/appBar.dart';
import '../../dataJson/userData.dart';
import './sendPhoto.dart';
import './photoViewManager.dart';
import '../../components/statusView.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key key, this.detail}) : super(key: key);

  /// 用户详情
  final Map detail;

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  /// 返回朋友圈一年的Item
  Widget _returnTimeLineItem(key) {
    return StickyHeader(
      overlapHeaders: true,
      header: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          width: ScreenUtil().setWidth(140),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(
                      width: ScreenUtil().setHeight(2),
                      color: Color(0xFFededed)))),
          child: Text(
            key.toString() + '年',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFcccccc), fontSize: ScreenUtil().setSp(35)),
          )),
      content: Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(65), left: ScreenUtil().setWidth(140)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(140),
        decoration: BoxDecoration(
            color: Color(0xFFf1f1f1),
            border: Border(
                top: BorderSide(
                    width: ScreenUtil().setHeight(2),
                    color: Color(0xFFededed)))),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[]
            ..addAll(timeLineList[key].map((res) => _returnPostList(res))),
        ),
      ),
    );
  }

  /// 返回朋友圈单个的item
  Widget _returnPostList(item) {
    return Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            top: ScreenUtil().setWidth(30)),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                child: Row(
                  children: <Widget>[
                    StatusHeaderImage(
                        imageSrc: item['avatar'],
                        width: 66,
                        height: 66,
                        radius: 33,
                        needBorder: true),
                    Text('  ${item['name']}',
                        style: TextStyle(
                            color: Color(0xFF9e9d9d),
                            fontSize: ScreenUtil().setSp(30)))
                  ],
                ),
              ),
              Text('${item['time']}',
                  style: TextStyle(
                      color: Color(0xFF9e9d9d),
                      fontSize: ScreenUtil().setSp(30)))
            ],
          ),
          Container(
            width:
                MediaQuery.of(context).size.width - ScreenUtil().setWidth(140),
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: Text('${item['content']}',
                style: TextStyle(fontSize: ScreenUtil().setSp(30))),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            width:
                MediaQuery.of(context).size.width - ScreenUtil().setWidth(140),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: ScreenUtil().setWidth(10),
              runSpacing: ScreenUtil().setWidth(10),
              children: <Widget>[]
                ..addAll(_returnImageList(item['imageUrlList'])),
            ),
          ),
          GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                        bottom: BorderSide(
                            width: ScreenUtil().setHeight(2),
                            color: Color(0xFFcccccc)))),
                alignment: Alignment.centerRight,
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
                child: Icon(Feather.more_horizontal)),
            onTap: () {
              print('touch the more');
            },
          )
        ]));
  }

  /// 返回图片九宫格
  List<Widget> _returnImageList(list) {
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList.add(GestureDetector(
        child: Container(
            width: ScreenUtil().setWidth(160),
            height: ScreenUtil().setWidth(160),
            color: Colors.black38,
            child: StatusImage(imageSrc: list[i], width: 160, height: 160)),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PhotoViewer(url: list[i])));
        },
      ));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, translate('title.dynamic'),
            backgroundColor: Colors.transparent,
            textColor: Colors.black,
            iconColor: Colors.black,
            actions: [
              TextButton(
                text: translate('dynamic.create'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SendPhoto()));
                },
              )
            ]),
        body: ListView.builder(
            itemCount: timeLineList.keys.length,
            itemBuilder: (context, index) {
              List<String> keys = timeLineList.keys.toList();
              return _returnTimeLineItem(keys[index]);
            }));
  }
}
