import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../components/statusView.dart';
import '../chat/chat.dart';
import '../../components/menuFloatButton.dart';
import '../../components/searchPage.dart';
import '../../dataJson/userData.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

final SlidableController slidableController = SlidableController();

class _ContactsState extends State<Contacts> {
  /// 返回单个的用户
  _returnUserItem(index) {
    Map item = userInfoList[index];

    return GestureDetector(
      child: Slidable(
        key: Key('$item.id'),
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
                    vertical: ScreenUtil().setHeight(30)),
                height: ScreenUtil().setHeight(140),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      child: StatusHeaderImage(
                          imageSrc: item['imageUrl'],
                          width: 80,
                          height: 80,
                          radius: 40),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(10)),
                                      child: Text(
                                        '${item['name']}',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(30)),
                                      )),
                                  item['hasStrongTip']
                                      ? Icon(
                                          Icons.star,
                                          color: Color(0xFFfadb14),
                                          size: ScreenUtil().setWidth(30),
                                        )
                                      : item['dontDisturb']
                                          ? Icon(
                                              Icons.do_not_disturb_off,
                                              color: Color(0xFFcccccc),
                                              size: ScreenUtil().setWidth(30),
                                            )
                                          : Container()
                                ],
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
              caption: '置顶',
              color: Color(0xFFc5c5cf),
              iconWidget: Icon(Feather.arrow_up,
                  color: Colors.white, size: ScreenUtil().setSp(50)),
              foregroundColor: Colors.white,
              onTap: () {
                setState(() {
                  userInfoList.forEach((res) => res['isTop'] = false);
                  userInfoList[index]['isTop'] = true;
                });
              }),
          IconSlideAction(
            caption: '删除',
            color: Color(0xFFf76767),
            iconWidget: Icon(Feather.trash_2,
                color: Colors.white, size: ScreenUtil().setSp(50)),
            onTap: () {
              setState(() {
                userInfoList.remove(userInfoList[index]);
              });
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ChatPage(detail: item);
        }));
      },
    );
  }

  /// 返回所有联系人列表
  _returnContactsList() {
    List widgetList = <Widget>[];

    for (var i = 0; i < userInfoList.length; i++) {
      if (userInfoList[i]['isTop'] == true) {
        widgetList.insert(0, _returnUserItem(i));
      } else {
        widgetList.add(_returnUserItem(i));
      }
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        OverflowBox(
          maxWidth: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              GestureDetector(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    height: ScreenUtil().setHeight(80),
                    color: Color(0xFFefeef3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(50)),
                            child: Text(translate("search.search")),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.keyboard_voice,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            print('语音');
                          },
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage()));
                },
              )
            ]..addAll(_returnContactsList()),
          ),
        ),
        MenuFloatButton()
      ],
    ));
  }
}
