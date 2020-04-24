import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../components/appbar.dart';

class SearchFriendPage extends StatefulWidget {
  SearchFriendPage({Key key, this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> downList = [
    {'icon': Feather.rss, 'title': '雷达添加朋友', 'subtitle': '添加身边的朋友'},
    {'icon': Feather.phone_call, 'title': '面对面建群', 'subtitle': '与身边的朋友进入同一个群聊'},
    {'icon': Feather.maximize, 'title': '扫一扫', 'subtitle': '扫描二维码名牌'},
    {'icon': Feather.phone, 'title': '手机联系人', 'subtitle': '添加或邀请通讯录的朋友'},
    {'icon': Feather.target, 'title': '公众号', 'subtitle': '获取更多资讯和服务'},
    {'icon': Feather.sun, 'title': '企业微信联系人', 'subtitle': '通过手机号搜索企业微信用户'},
  ];

  List<Widget> returnWidgetList() {
    List<Widget> list = [];
    downList.forEach((item) => list.add(returnItem(item)));
    return list;
  }

  returnItem(item) {
    return Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(
                    color: Color(0xFFe1e1e1),
                    width: ScreenUtil().setHeight(2)))),
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(15)),
            height: ScreenUtil().setHeight(120),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                  child: Icon(item['icon']),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${item['title']}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                      ),
                      Text('${item['subtitle']}',
                          style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: ScreenUtil().setSp(26)))
                    ],
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCustomAppBar(
        context,
        '添加朋友',
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              height: ScreenUtil().setHeight(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.search),
                  Container(
                      width: MediaQuery.of(context).size.width -
                          ScreenUtil().setWidth(100),
                      child: CupertinoTextField(
                        autofocus: true,
                        focusNode: _focusNode,
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        placeholder: '请输入微信号/公众号...',
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(15)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0)),
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: ScreenUtil().setSp(26),
                        ),
                        placeholderStyle: TextStyle(
                          color: Color(0xffbbbbbb),
                          fontSize: ScreenUtil().setSp(22),
                        ),
                        suffix: GestureDetector(
                          child: Icon(Icons.close,
                              size: ScreenUtil().setWidth(30)),
                          onTap: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        ),
                        onChanged: (val) {},
                      ))
                ],
              )),
          Container(
            height: ScreenUtil().setHeight(90),
            color: Color(0xFFededed),
            alignment: Alignment.center,
            child:
                Text('Github链接: https://github.com/kuaifengle/Flutter-WeChat',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(22),
                    )),
          ),
        ]..addAll(returnWidgetList()),
      )),
    );
  }
}
