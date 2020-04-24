import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../components/appBar.dart';
import '../talk/talk.dart';
import '../../dataJson/userData.dart';
import '../../components/searchPage.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final SlidableController slidableController = SlidableController();

  returnUserItem(item) {
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
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${item['imageUrl']}'),
                      ),
                    ),
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
                          Text('${item['checkInfo']}',
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
            onTap: () => _showSnackBar('删除'),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Talk(detail: item);
        }));
      },
    );
  }

  _showSnackBar(val) {
    print(val);
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(context, '联系人'),
        body: ListView.builder(
            itemCount: a2z.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      height: ScreenUtil().setHeight(80),
                      color: Color(0xFFefeef3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.search),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20)),
                              child: Text('Search'),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => SearchPage()));
                  },
                );
              } else {
                return StickyHeader(
                  header: Container(
                    height: ScreenUtil().setHeight(50),
                    decoration: BoxDecoration(
                        color: Color(0xFFc1c1c3),
                        border: Border(
                            top: BorderSide(
                                width: ScreenUtil().setHeight(2),
                                color: Colors.white))),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(30)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      a2z[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                  content: (friendInfoList[a2z[index]] != null &&
                          friendInfoList[a2z[index]].length > 0)
                      ? Column(
                          children: <Widget>[]..addAll(
                              friendInfoList[a2z[index]]
                                  .map((item) => returnUserItem(item))),
                        )
                      : Container(),
                );
              }
            }));
  }
}
