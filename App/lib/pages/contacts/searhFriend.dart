import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/appbar.dart';
import '../../components/searchPage.dart';

class SearchFriendPage extends StatefulWidget {
  SearchFriendPage({Key key, this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

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
                      width: MediaQuery.of(context).size.width - 50,
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
                          child: Icon(Icons.close, size: 20),
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
            height: ScreenUtil().setHeight(100),
            color: Color(0xFFededed),
            alignment: Alignment.center,
            child: Text('我的Github链接: https://github.com/kuaifengle',
                style: TextStyle(
                    color: Color(0xFF555555), fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.wifi_tethering, size: 35.0),
            title: Text('雷达添加朋友'),
            subtitle: Text('添加身边的朋友'),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          ListTile(
            leading: Icon(Icons.people_outline, size: 35.0),
            title: Text('面对面建群'),
            subtitle: Text('与身边的朋友进入同一个群聊'),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          ListTile(
            leading: Icon(Icons.camera_alt, size: 35.0),
            title: Text('扫一扫'),
            subtitle: Text('扫描二维码名牌'),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          ListTile(
            leading: Icon(Icons.perm_contact_calendar, size: 35.0),
            title: Text('手机联系人'),
            subtitle: Text('添加或邀请通讯录的朋友'),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          ListTile(
            leading: Icon(Icons.info_outline, size: 35.0),
            title: Text('公众号'),
            subtitle: Text('获取更多资讯和服务'),
          ),
          Divider(height: 2.0, color: Color(0xFFededed)),
          ListTile(
            leading: Icon(Icons.group_work, size: 35.0),
            title: Text('企业微信联系人'),
            subtitle: Text('通过手机号搜索企业微信用户'),
          ),
        ],
      )),
    );
  }
}
