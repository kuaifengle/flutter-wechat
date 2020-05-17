import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../components/appBar.dart';
import '../detail/detailed.dart';
import '../../dataJson/userData.dart';
import '../../components/statusView.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final SlidableController _slidableController = SlidableController();

  final ScrollController _scrollController = ScrollController();

  /// 搜索框控制器
  final TextEditingController _searchController = TextEditingController();

  /// 搜索框焦点
  FocusNode _focusNode = FocusNode();

  /// 所有搜索列表
  List<Map<String, dynamic>> _searchList = [];

  GlobalKey _columnKey = GlobalKey();

  /// 显示提示框
  bool _showTip = true;

  String _tipText = '';

  /// 搜索内容
  String _searchVal = '';

  double dragDouble = 0.0;

  /// 侧滑栏距离屏幕顶部的距离
  double _columnOffsetTop = 0;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox key = _columnKey.currentContext.findRenderObject();
      _columnOffsetTop = key.localToGlobal(Offset.zero).dy;
    });
  }

  searchFriend() {
    if (_searchVal == '') {
      setState(() {
        _searchList = [];
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
      _searchList = list.length > 0
          ? list
          : [
              {'noData': true}
            ];
    });
  }

  returnUserItem(
    item,
    index,
  ) {
    String heroTag = index.toString() + item['id'].toString();
    if (item['noData'] != null && item['noData']) {
      return Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
          child: Center(
            child: Text('暂无数据...'),
          ));
    }

    return GestureDetector(
      child: Slidable(
        key: Key('$item.id'.toString()),
        actionPane: SlidableScrollActionPane(),
        controller: _slidableController,
        actionExtentRatio: 0.2,
        child: Container(
            decoration: BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
                        color: Color(0xFFe1e1e1),
                        width: ScreenUtil().setHeight(2)))),
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(35),
                    vertical: ScreenUtil().setHeight(15)),
                height: ScreenUtil().setHeight(120),
                child: Row(
                  children: <Widget>[
                    Hero(
                        tag: heroTag,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                          child: StatusHeaderImage(
                              imageSrc: item['imageUrl'],
                              width: 80,
                              height: 80,
                              radius: 40),
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${item['name']}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(30)),
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

  /// 计算滑动距离
  _calcScrollerChange(dy) {
    dragDouble = dy - _columnOffsetTop;
    if (dragDouble <= 0) {
      return;
    } else {
      int length = 0;
      int pos = (dragDouble / ScreenUtil().setHeight(35)).floor();
      for (int i = 0; i < pos; i++) {
        length +=
            friendInfoList[a2z[i]] != null ? friendInfoList[a2z[i]].length : 0;
      }
      dragDouble = 0;
      _timer?.cancel();

      setState(() {
        _showTip = false;
        _tipText = a2z[pos];
      });
      _scrollController.jumpTo(length * ScreenUtil().setHeight(122) +
          pos * ScreenUtil().setHeight(50) +
          (pos > 0 ? ScreenUtil().setHeight(81) : 0));

      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          _showTip = true;
          _timer?.cancel();
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, translate("title.contacts")),
        body: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: 1 + _searchList.length + a2z.length,
                shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
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
                                placeholder: translate("search.contacts"),
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
                                            _searchList = [];
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
                  } else if (_searchList.length > 0 &&
                      index > 0 &&
                      index <= _searchList.length) {
                    return returnUserItem(_searchList[index - 1], a2z[index]);
                  } else if (_searchList.length == 0 ||
                      (_searchList[0] != null &&
                          _searchList[0]['notData'] != null)) {
                    int key = index - 1;
                    // if (friendInfoList[a2z[key]] == null ||
                    //     friendInfoList[a2z[key]].length == 0) {
                    //   return Container();
                    // }
                    return StickyHeader(
                        key: Key('header' + key.toString()),
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
                        content: !(friendInfoList[a2z[key]] == null ||
                                friendInfoList[a2z[key]].length == 0)
                            ? Column(
                                children: <Widget>[]..addAll(
                                    friendInfoList[a2z[key]].map((item) =>
                                        returnUserItem(item, a2z[key]))),
                              )
                            : Container());
                  }
                }),
            _searchVal.length > 0
                ? Positioned(
                    child: Container(),
                  )
                : Positioned(
                    top: 0,
                    right: 0,
                    width: ScreenUtil().setWidth(50),
                    height: MediaQuery.of(context).size.height -
                        ScreenUtil().setHeight(140),
                    child: Container(
                      color: Colors.transparent,
                      child: GestureDetector(
                          onPanStart: (detail) {
                            dragDouble = detail.globalPosition.dy;
                          },
                          onPanUpdate: (detail) {
                            _calcScrollerChange(detail.globalPosition.dy);
                          },
                          onPanEnd: (detail) {
                            _calcScrollerChange(dragDouble);
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[SizedBox(key: _columnKey)]
                                ..addAll(a2z.map((res) {
                                  return SizedBox(
                                    width: ScreenUtil().setWidth(50),
                                    height: ScreenUtil().setHeight(35),
                                    child: Text(
                                      res,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: ScreenUtil().setSp(30)),
                                    ),
                                  );
                                })))),
                    ),
                  ),
            Positioned(
              top: (MediaQuery.of(context).size.height -
                      ScreenUtil().setWidth(450)) /
                  2,
              left: (MediaQuery.of(context).size.width -
                      ScreenUtil().setWidth(200)) /
                  2,
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setWidth(200),
              child: Offstage(
                offstage: _showTip,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(20)))),
                  child: Text(
                    _tipText,
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(50)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
