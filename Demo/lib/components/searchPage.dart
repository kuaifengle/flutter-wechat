import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_translate/flutter_translate.dart';

import './button.dart';
import './dialog.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget _searchWrap;
  String _searchVal = '';

  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  /// 构建搜索历史列表
  _buildSearchHistory(searchList) {
    List<Widget> widgetList = [];
    for (var i = 0; i < searchList.length; i++) {
      var text = searchList[i];
      widgetList.add(GestureDetector(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setWidth(15)),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              text,
              style: TextStyle(
                  color: Color(0xFF333333), fontSize: ScreenUtil().setSp(26)),
            )),
        onTap: () {
          _searchController.value = TextEditingValue(
              text: text,
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream, offset: text.length)));

          setState(() {
            _searchVal = _searchController.text;
          });
        },
      ));
    }

    setState(() {
      _searchWrap = Wrap(
        spacing: 10.0, // gap between adjacent chips
        runSpacing: 6.0,
        children: widgetList,
      );
    });
  }

  // 读取搜索历史列表
  void _getSearchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var arr = prefs.getStringList('searchHistory');
    List<String> searchList = arr == null ? [] : arr;
    _buildSearchHistory(searchList);
  }

  // 储存搜索历史
  void _writeSearchHistory(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var arr = prefs.getStringList('searchHistory');
    List<String> searchList = arr == null ? [] : arr;
    if (searchList.indexOf(value) < 0) {
      searchList.insert(0, value);
      if (searchList.length >= 20) {
        searchList.removeAt(0);
      }
      await prefs.setStringList('searchHistory', searchList);
      _getSearchList();
    }
  }

  @override
  void initState() {
    super.initState();
    _getSearchList();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0.0,
          ),
        ),
        body: Container(
            child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
                color: Color(0xFFf1f1f1),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(15),
                      horizontal: ScreenUtil().setHeight(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          CupertinoTextField(
                            autofocus: true,
                            focusNode: _focusNode,
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            maxLength: 50,
                            placeholder: translate('search.contacts'),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(30),
                                vertical: ScreenUtil().setHeight(15)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60.0),
                                border: Border.all(
                                  width: ScreenUtil().setHeight(1),
                                  color: Color(0xFFdddddd),
                                )),
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
                                  color: Color(0xFF333333),
                                  size: ScreenUtil().setWidth(40)),
                              onTap: () {
                                _searchController.clear();
                                setState(() {
                                  _searchVal = '';
                                });
                              },
                            ),
                            onChanged: (val) {
                              setState(() {
                                _searchVal = val;
                              });
                            },
                            onSubmitted: (value) async {
                              if (value != null && value != '') {
                                _writeSearchHistory(value);
                              }
                              _searchController.clear();
                              _searchVal = '';
                            },
                            onEditingComplete: () {
                              String value = _searchController.text;
                              if (value != null && value != '') {
                                _writeSearchHistory(value);
                              }
                              _searchController.clear();
                              _searchVal = '';
                            },
                          )
                        ],
                      )),
                      _searchVal.length > 0
                          ? TextButton(
                              text: '确认',
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setHeight(30),
                                  vertical: ScreenUtil().setHeight(10)),
                              textColor: Color(0XFF4ba7e5),
                              onPressed: () {
                                _writeSearchHistory(_searchVal);
                              },
                            )
                          : TextButton(
                              text: '取消',
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setHeight(30),
                                  vertical: ScreenUtil().setHeight(10)),
                              textColor: Color(0XFF333333),
                              onPressed: () {
                                _focusNode.unfocus();
                                Navigator.of(context).pop();
                              },
                            )
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setHeight(20),
                  vertical: ScreenUtil().setHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('历史搜索'),
                  IconButton(
                    icon: Icon(
                      Feather.trash_2,
                      color: Color(0xFF333333),
                      size: ScreenUtil().setWidth(40),
                    ),
                    onPressed: () async {
                      UtilDialog.showConfirm(context, content: '确实要清空搜索历史?',
                          successFn: () async {
                        Navigator.of(context).pop();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setStringList('searchHistory', []);
                        _getSearchList();
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(20)),
                child: _searchWrap),
          ],
        )));
  }
}
