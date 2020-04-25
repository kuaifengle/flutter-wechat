import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/cupertino.dart';

import '../../components/appBar.dart';
import '../contacts/detailed.dart';
import '../../dataJson/userData.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final SlidableController slidableController = SlidableController();

  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> searchList = [];
  String _searchVal = '';

  searchFriend() {
    if (_searchVal == '') {
      setState(() {
        searchList = [];
      });
      return;
    }
    List<Map<String, dynamic>> list = [];

    friendInfoList.keys.toList().forEach((k) {
      List userInfoList = friendInfoList[k];

      userInfoList.forEach((res) {
        Map someRes = {
          'name': res['name'],
          'motto': res['motto'],
          'checkInfo': res['checkInfo'],
          'adress': res['adress'],
        };
        String allValues = someRes.values.toString();
        if (allValues.indexOf(_searchVal) > -1) {
          list.add(res);
        }
      });
    });

    setState(() {
      searchList = list;
    });
  }

  returnUserItem(item, index) {
    String heroTag = index.toString() + item['id'].toString();

    return GestureDetector(
      child: Slidable(
        key: Key('$item.id'.toString()),
        actionPane: SlidableScrollActionPane(),
        controller: slidableController,
        actionExtentRatio: 0.2,
        child: Container(
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
                    Hero(
                        tag: heroTag,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${item['imageUrl']}'),
                          ),
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${item['name']}',
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(30)),
                              ),
                              Text('${item['lastTime']}',
                                  style: TextStyle(
                                      color: Color(0xFF888888),
                                      fontSize: ScreenUtil().setSp(22)))
                            ],
                          ),
                          Text('${item['motto']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: ScreenUtil().setSp(26)))
                        ],
                      ),
                    ),
                  ],
                ))),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '删除',
            color: Color(0xFFf76767),
            iconWidget: Icon(Feather.trash_2,
                color: Colors.white, size: ScreenUtil().setSp(50)),
            onTap: () {
              setState(() {
                friendInfoList[index].remove(item);
              });
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Detailed(detail: item, heroTag: heroTag);
        }));
      },
    );
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, '通讯录'),
        body: ListView.builder(
            itemCount: 1 + searchList.length + a2z.length,
            itemBuilder: (context, index) {
              Widget widget;
              if (index == 0) {
                widget = Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    height: ScreenUtil().setHeight(80),
                    color: Color(0xFFefeef3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.black54),
                        Expanded(
                          child: CupertinoTextField(
                            focusNode: _focusNode,
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            maxLength: 50,
                            placeholder: '请输入微信号/手机号...',
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
                              color: Color(0xFFc1c1c3),
                              fontSize: ScreenUtil().setSp(22),
                            ),
                            suffix: _searchVal.length > 0
                                ? GestureDetector(
                                    child: Icon(Icons.close,
                                        color: Color(0xFF333333),
                                        size: ScreenUtil().setWidth(30)),
                                    onTap: () {
                                      _searchController.clear();
                                      setState(() {
                                        searchList = [];
                                      });
                                    },
                                  )
                                : Container(),
                            onChanged: (val) {
                              _searchVal = val;
                              searchFriend();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ));
              } else if (searchList.length > 0 &&
                  index > 0 &&
                  index <= searchList.length) {
                return returnUserItem(searchList[index - 1], a2z[index]);
              } else {
                int key = index - 1;
                if (friendInfoList[a2z[key]] != null &&
                    friendInfoList[a2z[key]].length > 0) {
                  widget = StickyHeader(
                      header: Container(
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(color: Colors.black38),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setHeight(30)),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          a2z[key],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(30)),
                        ),
                      ),
                      content: Column(
                        children: <Widget>[]..addAll(friendInfoList[a2z[key]]
                            .map((item) => returnUserItem(item, a2z[key]))),
                      ));
                }
              }
              return widget;
            }));
  }
}
