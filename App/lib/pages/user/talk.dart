import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import './detailed.dart';

class Talk extends StatefulWidget{
  Talk({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _TalkState createState() => new _TalkState();
}

class _TalkState extends State<Talk> with SingleTickerProviderStateMixin{
  var fsNode1 = new FocusNode();
  var _textInputController = new TextEditingController();
  var _scrollController = new ScrollController();
  List<Widget> talkWidgetList = <Widget>[];
  List<Map> talkHistory = [];
  bool talkFOT = false;
  bool otherFOT = false;

  Animation animationTalk;
  AnimationController controller;

    @override
    void initState() {
      controller = new AnimationController(duration: new Duration(seconds: 1), vsync: this);
      animationTalk = new Tween(begin: 1.0, end: 1.5).animate(controller)
      ..addStatusListener((state){
        if(state == AnimationStatus.completed) {
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
      // TODO: implement dispose
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

    for(var i = 0; i < talkHistory.length; i ++) {
      widgetList.add(returnTalkItem(talkHistory[i]));
    }

    setState(() {
      talkWidgetList = widgetList;
      _scrollController.animateTo( 50.0 * talkHistory.length + 100,duration: new Duration(seconds: 1), curve: Curves.ease);
    });
  }

void  getImage() async {
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

    Future.delayed(new Duration(seconds: 1), (){
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
    switch(type) {
      case 'text':
        return new Text(val,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 100,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      height: 1,
                    )
        );
      break;
      case 'image':
        return new Image.file(val);
      break;
      case 'text':
        return new Text(val);
      break;
    }
  }


  returnTalkItem(item) {
    List<Widget> widgetList = [];

    if(item['id'] != widget.detail['id']){
      // 非本人的信息
      widgetList = [
          new Container(
              margin: new EdgeInsets.only(right: 20.0),
              padding: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: new BorderRadius.circular(10.0)
              ),
              child: new LimitedBox(
                maxWidth: MediaQuery.of(context).size.width - 120.0,
                child: returnTalkType(item['type'], item['content']),
              )
          ),
          new CircleAvatar(
            backgroundImage: new NetworkImage('${item['imageUrl']}'),
          ),
      ];
    } else {
      // 本人的信息
      widgetList = [
          new CircleAvatar(
            backgroundImage: new NetworkImage('${item['imageUrl']}'),
          ),
          new Container(
              margin: new EdgeInsets.only(left: 20.0),
              padding: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: new BorderRadius.circular(10.0)
              ),
              child: new LimitedBox(
                maxWidth: MediaQuery.of(context).size.width - 120.0,
                child: returnTalkType(item['type'], item['content'])
              ),
          ),
      ];
    }

    return new Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          mainAxisAlignment: widget.detail['id'] == item['id'] ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgetList
        )
    );
  }

  @override
  Widget build(BuildContext context){

    return new WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
      },
      child:  new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          title: new Text('${widget.detail['name']}', style: new TextStyle(fontSize: 20.0),),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.person, size:30.0),
              onPressed: (){
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (_) => new Detailed(detail: widget.detail)
                  )
                );
              },
            )
          ],
          centerTitle: true,
        ),
        body: new Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                padding: new EdgeInsets.only(bottom: 50.0),
                // width: MediaQuery.of(context).size.width - 40.0,
                child: ListView(
                  controller: _scrollController,
                  children: talkWidgetList,
                ),
              ),
              new Positioned(
                bottom: 0,
                left:0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Color(0xFFebebf3),
                  child: new Column(
                    children: <Widget>[
                      new Offstage(
                        offstage: talkFOT,
                        child:  new Row(
                          children: <Widget>[
                            new Container(
                              width: 40.0,
                              color: Color(0xFFaaaab6),
                              child: new IconButton(
                                icon: new Icon(Icons.keyboard_voice),
                                onPressed: (){
                                  setState(() {
                                    fsNode1.unfocus();
                                    talkFOT = !talkFOT;
                                    otherFOT = false;
                                  });
                                },
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.symmetric(horizontal: 10.0),
                              width: MediaQuery.of(context).size.width - 140.0,
                              child: new TextField(
                                focusNode: fsNode1,
                                controller: _textInputController,
                                decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: '输入你的信息...',
                                hintStyle: new TextStyle(
                                    color: Color(0xFF7c7c7e)
                                  )
                                ),
                                onSubmitted: (val){
                                  if (val != '' && val != null) {
                                    getTalkList();
                                    autoTalk(val, 'text');
                                  }
                                  _textInputController.clear();
                                },
                              ),
                            ),
                            new IconButton(
                              icon: Icon(Icons.insert_emoticon, color: Color(0xFF707072)),
                              onPressed: (){
                                
                              },
                            ),
                            new IconButton(
                              icon: Icon(Icons.add_circle_outline, color: Color(0xFF707072)),
                              onPressed: (){
                                setState(() {
                                  fsNode1.unfocus();
                                  otherFOT = !otherFOT;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      new Offstage( // 录音按钮
                        offstage: !talkFOT,
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              height: 30.0,
                              color: Color(0xFFededed),
                              alignment: Alignment.centerLeft,
                              child: new IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: (){
                                  controller.reset();
                                  controller.stop();
                                  setState(() {
                                    talkFOT = !talkFOT;
                                  });
                                },
                              ),
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170.0,
                              color: Color(0xFFededed),
                              child: new Center(
                                child: new AnimatedBuilder(
                                  animation: animationTalk,
                                  builder: (_, child){
                                  return new GestureDetector(
                                    child: new CircleAvatar(
                                      radius: animationTalk.value * 30,
                                      backgroundColor: Color(0x306b6aba),
                                        child: new Center(
                                          child: Icon(Icons.keyboard_voice, size: 30.0, color:Color(0xFF6b6aba)),
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
                                )
                              ),
                            ),
                          ],
                        )
                      ),
                      new Offstage( // 图片选择
                        offstage: !otherFOT,
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                width: MediaQuery.of(context).size.width,
                                height: 170.0,
                                color: Color(0xFFededed),
                                child: Wrap(
                                  spacing: 25.0,
                                  runSpacing: 10.0,
                                  children: <Widget>[
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.photo_size_select_actual, color: Colors.black38),
                                        onPressed: () {
                                          getImage();
                                        },
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.videocam, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.linked_camera, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.add_location, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.library_music, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.library_books, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.video_library, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                    new Container(
                                      width: (MediaQuery.of(context).size.width - 100) / 4,
                                      height: (MediaQuery.of(context).size.width - 100) / 4,
                                      color: Color(0xFFffffff),
                                      child: new IconButton(
                                        iconSize: 50.0,
                                        icon: Icon(Icons.local_activity, color: Colors.black38),
                                        onPressed: (){},
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ],
                          )
                        )
                      )
                    ],
                  )
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}