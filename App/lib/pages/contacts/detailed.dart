import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../index/talk.dart';
import '../dynamic/timeLine.dart';
import './friendSetting.dart';

class Detailed extends StatefulWidget {
  Detailed({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _DetailedState createState() => _DetailedState();
}

class _DetailedState extends State<Detailed> {
  @override
  Widget build(BuildContext context) {
    var pohtoWith =
        (MediaQuery.of(context).size.width - ScreenUtil().setWidth(350)) / 4;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setHeight(550),
              child: Stack(
                children: <Widget>[
                  Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: ScreenUtil().setHeight(500),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.detail['backgroundUrl']),
                                fit: BoxFit.fill)),
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_left,
                                color: Colors.white, size: 30.0),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                'Ta的详情',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(32),
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: ScreenUtil().setHeight(70),
                      width: MediaQuery.of(context).size.width,
                      height: ScreenUtil().setHeight(500),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(60),
                        ),
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: ScreenUtil().setWidth(140),
                                height: ScreenUtil().setWidth(140),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.detail['imageUrl']),
                                        fit: BoxFit.fill),
                                    border: Border.all(
                                        width: ScreenUtil().setWidth(4),
                                        color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(140)))),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'kuaifengle',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(34),
                                          height: 2),
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
                                            color: Color(0xFF333333),
                                            fontSize: ScreenUtil().setSp(26),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Positioned(
                      right: 15.0,
                      bottom: 0.0,
                      child: FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        backgroundColor: Color(0xFF6b6aba),
                        child: Icon(
                          Icons.settings,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => FriendSetting()));
                        },
                      ))
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(150),
                  child: Text('地址:'),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '中国-广州-深圳',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF3d3d3d),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ))
              ],
            ),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(150),
                  child: Text('签名:'),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.detail['checkInfo']}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF3d3d3d),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ))
              ],
            ),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                  vertical: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(150),
                    child: Text('相册:'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.network(widget.detail['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: pohtoWith,
                                    height: pohtoWith),
                                Image.network(widget.detail['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: pohtoWith,
                                    height: pohtoWith),
                                Image.network(widget.detail['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: pohtoWith,
                                    height: pohtoWith),
                                Image.network(widget.detail['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: pohtoWith,
                                    height: pohtoWith),
                              ],
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenUtil().setHeight(25),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TimeLine(detail: widget.detail)));
            },
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(100),
                right: ScreenUtil().setWidth(100),
                top: ScreenUtil().setHeight(50),
                bottom: ScreenUtil().setHeight(15)),
            child: RaisedButton(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
              color: Color(0xFF64c223),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Feather.send, size: 16, color: Colors.white),
                  Text(
                    '  发送消息',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Talk(detail: widget.detail)));
              },
            ),
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(100)),
            child: RaisedButton(
              elevation: 0,
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
              color: Color(0xFFededed),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Feather.video,
                      size: 16, color: Theme.of(context).primaryColor),
                  Text(
                    '  视频通话',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Talk(detail: widget.detail)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
