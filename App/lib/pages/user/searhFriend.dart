import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchFriendPage extends StatefulWidget{
  SearchFriendPage({Key key, this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  _SearchFriendPageState createState() => new _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage>{
  Widget searchWrap;

  var _searchController = new TextEditingController();
  var _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: new Text('添加朋友')
      ),
      body:  new Container(
        child: new ListView(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new TextField(
                focusNode: _focusNode,
                decoration: new InputDecoration(
                  icon: Icon(Icons.search)
                ),
                autofocus: false,
                onSubmitted: (String value) async{
                  if (value != null && value != '') {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var arr = prefs.getString('searchList');
                    var searchList = arr == null || arr.split(',') == null ? '' : arr;
                    prefs.setString('searchList', searchList + ','+ value.toString());
                  }
                },
                controller: _searchController,
              ),
            ),
            new Container(
              height: 60.0,
              color: Color(0xFFededed),
              alignment: Alignment.center,
              child: new Text('我的Github链接: https://github.com/kuaifengle', style: new TextStyle(color: Color(0xFF555555), fontWeight: FontWeight.bold)),
            ),
            new ListTile(
              leading: new Icon(Icons.wifi_tethering, size: 35.0),
              title: new Text('雷达添加朋友'),
              subtitle: new Text('添加身边的朋友'),
            ),
            new Divider(height: 2.0, color: Color(0xFFededed)),
            new ListTile(
              leading: new Icon(Icons.people_outline, size: 35.0),
              title: new Text('面对面建群'),
              subtitle: new Text('与身边的朋友进入同一个群聊'),
            ),
            new Divider(height: 2.0, color: Color(0xFFededed)),
            new ListTile(
              leading: new Icon(Icons.camera_alt, size: 35.0),
              title: new Text('扫一扫'),
              subtitle: new Text('扫描二维码名牌'),
            ),
            new Divider(height: 2.0, color: Color(0xFFededed)),
            new ListTile(
              leading: new Icon(Icons.perm_contact_calendar, size: 35.0),
              title: new Text('手机联系人'),
              subtitle: new Text('添加或邀请通讯录的朋友'),
            ),
            new Divider(height: 2.0, color: Color(0xFFededed)),
            new ListTile(
              leading: new Icon(Icons.info_outline, size: 35.0),
              title: new Text('公众号'),
              subtitle: new Text('获取更多资讯和服务'),
            ),
            new Divider(height: 2.0, color: Color(0xFFededed)),
            new ListTile(
              leading: new Icon(Icons.group_work, size: 35.0),
              title: new Text('企业微信联系人'),
              subtitle: new Text('通过手机号搜索企业微信用户'),
            ),
          ],
        )
      ),
    );
  }
}