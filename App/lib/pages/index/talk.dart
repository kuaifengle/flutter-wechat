import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'dart:convert';

import '../../components/appBar.dart';
import '../contacts/detailed.dart';

class Talk extends StatefulWidget {
  Talk({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _TalkState createState() => _TalkState();
}

class _TalkState extends State<Talk> with SingleTickerProviderStateMixin {
  var fsNode1 = FocusNode();
  var _textInputController = TextEditingController();
  var _scrollController = ScrollController();
  List<Widget> talkWidgetList = <Widget>[];
  List<Map> talkHistory = [];
  bool talkFOT = false;
  bool otherFOT = false;

  Animation animationTalk;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animationTalk = Tween(begin: 1.0, end: 1.5).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    fsNode1.addListener(_focusListener);

    super.initState();
  }

  _focusListener() async {
    if (fsNode1.hasFocus) {
      setState(() {
        otherFOT = false;
        talkFOT = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<String> returnTalkList = [
    '这是自动留言,我的手机不在身边, 有事请直接Call我....',
    '呵呵,真好笑!!!',
    '你最近好吗?',
    '如果我是DJ你会爱我吗?',
    'hohohohohoho, boom!',
    '刮风那天我试过牵着你手',
  ];

  getTalkList() {
    List<Widget> widgetList = [];

    for (var i = 0; i < talkHistory.length; i++) {
      widgetList.add(returnTalkItem(talkHistory[i]));
    }

    setState(() {
      talkWidgetList = widgetList;
      _scrollController.animateTo(50.0 * talkHistory.length + 100,
          duration: Duration(seconds: 1), curve: Curves.ease);
    });
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      autoTalk(image, 'image');
    }
  }

  autoTalk(val, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mySelf = json.decode(prefs.getString('userInfo'));

    talkHistory.add({
      'name': mySelf['name'],
      'id': mySelf['id'],
      'imageUrl': mySelf['imageUrl'],
      'content': val,
      'type': type // image text
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
      talkHistory.add(item);
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

  returnTalkItem(item) {
    List<Widget> widgetList = [];

    if (item['id'] != widget.detail['id']) {
      // 非本人的信息
      widgetList = [
        Container(
            margin: EdgeInsets.only(right: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: BorderRadius.circular(10.0)),
            child: LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(item['type'], item['content']),
            )),
        CircleAvatar(
          backgroundImage: NetworkImage('${item['imageUrl']}'),
        ),
      ];
    } else {
      // 本人的信息
      widgetList = [
        CircleAvatar(
          backgroundImage: NetworkImage('${item['imageUrl']}'),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Color(0xFFebebf3),
              borderRadius: BorderRadius.circular(10.0)),
          child: LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(item['type'], item['content'])),
        ),
      ];
    }

    return Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
            mainAxisAlignment: widget.detail['id'] == item['id']
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgetList));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        return Future(() => false);
      },
      child: Scaffold(
        appBar: setCustomAppBar(
          context,
          '${widget.detail['name']}',
          actions: <Widget>[
            IconButton(
              icon: Icon(Feather.list, size: ScreenUtil().setWidth(40)),
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
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.only(bottom: 50.0),
                  // width: MediaQuery.of(context).size.width - 40.0,
                  child: ListView(
                    controller: _scrollController,
                    children: talkWidgetList,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      color: Color(0xFFebebf3),
                      child: Column(
                        children: <Widget>[
                          Offstage(
                            offstage: talkFOT,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 40.0,
                                  color: Color(0xFFaaaab6),
                                  child: IconButton(
                                    icon: Icon(Icons.keyboard_voice),
                                    onPressed: () {
                                      setState(() {
                                        fsNode1.unfocus();
                                        talkFOT = !talkFOT;
                                        otherFOT = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  width:
                                      MediaQuery.of(context).size.width - 140.0,
                                  child: TextField(
                                    focusNode: fsNode1,
                                    controller: _textInputController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '输入你的信息...',
                                        hintStyle: TextStyle(
                                            color: Color(0xFF7c7c7e))),
                                    onSubmitted: (val) {
                                      if (val != '' && val != null) {
                                        getTalkList();
                                        autoTalk(val, 'text');
                                      }
                                      _textInputController.clear();
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.insert_emoticon,
                                      color: Color(0xFF707072)),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline,
                                      color: Color(0xFF707072)),
                                  onPressed: () {
                                    setState(() {
                                      fsNode1.unfocus();
                                      otherFOT = !otherFOT;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Offstage(
                              // 录音按钮
                              offstage: !talkFOT,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    color: Color(0xFFededed),
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () {
                                        controller.reset();
                                        controller.stop();
                                        setState(() {
                                          talkFOT = !talkFOT;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 170.0,
                                    color: Color(0xFFededed),
                                    child: Center(
                                        child: AnimatedBuilder(
                                      animation: animationTalk,
                                      builder: (_, child) {
                                        return GestureDetector(
                                          child: CircleAvatar(
                                            radius: animationTalk.value * 30,
                                            backgroundColor: Color(0x306b6aba),
                                            child: Center(
                                              child: Icon(Icons.keyboard_voice,
                                                  size: 30.0,
                                                  color: Color(0xFF6b6aba)),
                                            ),
                                          ),
                                          onLongPress: () {
                                            controller.forward();
                                          },
                                          onLongPressUp: () {
                                            controller.reset();
                                            controller.stop();
                                          },
                                        );
                                      },
                                    )),
                                  ),
                                ],
                              )),
                          Offstage(
                              // 图片选择
                              offstage: !otherFOT,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 170.0,
                                          color: Color(0xFFededed),
                                          child: Wrap(
                                            spacing: 25.0,
                                            runSpacing: 10.0,
                                            children: <Widget>[
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons
                                                          .photo_size_select_actual,
                                                      color: Colors.black38),
                                                  onPressed: () {
                                                    getImage();
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(Icons.videocam,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons.linked_camera,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(Icons.add_location,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons.library_music,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons.library_books,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons.video_library,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100) /
                                                    4,
                                                color: Color(0xFFffffff),
                                                child: IconButton(
                                                  iconSize: 50.0,
                                                  icon: Icon(
                                                      Icons.local_activity,
                                                      color: Colors.black38),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )))
                        ],
                      )),
                )
              ],
            )),
      ),
    );
  }
}
