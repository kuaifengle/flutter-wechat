import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../dataJson/userData.dart';
import '../../components/appBar.dart';
import '../contacts/detailed.dart';

class Talk extends StatefulWidget {
  Talk({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _TalkState createState() => _TalkState();
}

class _TalkState extends State<Talk> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var fsNode1 = FocusNode();
  var _textInputController = TextEditingController();
  var _scrollController = ScrollController();
  List<Widget> talkWidgetList = <Widget>[];
  List<Map> talkHistory = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fsNode1.dispose();
    _textInputController.dispose();
  }

  getTalkList() {
    List<Widget> widgetList = [];

    for (var i = 0; i < talkHistory.length; i++) {
      widgetList.add(returnTalkItem(i, talkHistory[i]));
    }

    setState(() {
      talkWidgetList = widgetList;
    });
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      autoTalk(image, 'image');
    }
  }

  autoTalk(val, type) async {
    talkHistory.insert(0, {
      'name': mySelf['name'],
      'id': mySelf['id'],
      'imageUrl': mySelf['imageUrl'],
      'content': val,
      'type': type
    });
    getTalkList();

    Future.delayed(Duration(seconds: 1), () {
      var item = {
        'name': widget.detail['name'],
        'id': widget.detail['id'],
        'imageUrl': widget.detail['imageUrl'],
        'content': returnTalkList[talkHistory.length % 5],
        'type': 'text'
      };
      talkHistory.insert(0, item);
      getTalkList();
    });
  }

  returnTalkType(type, val) {
    switch (type) {
      case 'text':
        return Text(val,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 100,
            textAlign: TextAlign.left,
            style: TextStyle(
              height: 1,
            ));
        break;
      case 'image':
        return Image.file(val);
        break;
      case 'text':
        return Text(val);
        break;
    }
  }

  returnTalkItem(i, item) {
    List<Widget> widgetList = [
      Container(
          key: Key(i.toString()),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Color(0xFFebebf3),
              borderRadius: BorderRadius.circular(10.0)),
          child: LimitedBox(
            maxWidth:
                MediaQuery.of(context).size.width - ScreenUtil().setWidth(208),
            child: returnTalkType(item['type'], item['content']),
          ))
    ];

    bool isMySelf = widget.detail['id'] == item['id'];

    if (!isMySelf) {
      // 非本人的信息  isMyself
      widgetList.add(CircleAvatar(
        radius: ScreenUtil().setWidth(38),
        backgroundImage: NetworkImage('${item['imageUrl']}'),
      ));
    } else {
      // 本人的信息
      widgetList.insert(
          0,
          CircleAvatar(
            radius: ScreenUtil().setWidth(38),
            backgroundImage: NetworkImage('${item['imageUrl']}'),
          ));
    }

    return Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
        child: Row(
            mainAxisAlignment:
                isMySelf ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: []..addAll(widgetList)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        return Future(() => false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: setCustomAppBar(
          context,
          '${widget.detail['name']}',
          actions: <Widget>[
            IconButton(
              icon: Icon(Feather.more_horizontal,
                  size: ScreenUtil().setWidth(40)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Detailed(detail: widget.detail)));
              },
            )
          ],
        ),
        body: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                ListView(
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(90),
                      left: ScreenUtil().setWidth(20)),
                  controller: _scrollController,
                  children: talkWidgetList,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(90),
                  child: Container(
                      color: Color(0xFFececf4),
                      child: Offstage(
                        offstage: false,
                        child: Row(children: <Widget>[
                          GestureDetector(
                            child: Container(
                              color: Color(0xFFa8a8b4),
                              width: ScreenUtil().setWidth(90),
                              height: ScreenUtil().setHeight(90),
                              child: Icon(Feather.mic, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                fsNode1.unfocus();
                              });
                            },
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10)),
                            width: MediaQuery.of(context).size.width -
                                ScreenUtil().setWidth(250),
                            child: TextField(
                              focusNode: fsNode1,
                              controller: _textInputController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '输入你的信息...',
                                  hintStyle:
                                      TextStyle(color: Color(0xFF7c7c7e))),
                              onSubmitted: (val) {
                                if (val != '' && val != null) {
                                  getTalkList();
                                  autoTalk(val, 'text');
                                }
                                _textInputController.clear();
                              },
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: ScreenUtil().setWidth(70),
                              height: ScreenUtil().setHeight(90),
                              child:
                                  Icon(Feather.smile, color: Color(0xFF333333)),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              width: ScreenUtil().setWidth(70),
                              height: ScreenUtil().setHeight(90),
                              child: Icon(Feather.plus_circle,
                                  color: Color(0xFF333333)),
                            ),
                            onTap: () {},
                          )
                        ]),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
