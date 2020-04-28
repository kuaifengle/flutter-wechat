import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:bubble/bubble.dart';
import 'package:w_popup_menu/w_popup_menu.dart';

import '../../dataJson/userData.dart';
import '../../components/appBar.dart';
import '../detail/detailed.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  /// 信息输入框焦点
  var fsNode1 = FocusNode();

  /// 信息输入框
  var _textInputController = TextEditingController();

  /// 聊天历史
  List<Map> _chatHistory = [];

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

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _autoTalk(image, 'image');
    }
  }

  /// 发送消息
  _sendMessage(val, type) {
    setState(() {
      _chatHistory.insert(0, {
        'name': mySelf['name'],
        'id': mySelf['id'],
        'imageUrl': mySelf['imageUrl'],
        'content': val,
        'type': type
      });
    });
    _autoTalk(val, type);
  }

  /// 自动回复
  _autoTalk(val, type) async {
    Future.delayed(Duration(seconds: 1), () {
      var item = {
        'name': widget.detail['name'],
        'id': widget.detail['id'],
        'imageUrl': widget.detail['imageUrl'],
        'content': returnTalkList[_chatHistory.length % 5],
        'type': 'text'
      };

      setState(() {
        _chatHistory.insert(0, item);
      });
    });
  }

  /// 返回聊天类型
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
    }
  }

  /// 返回聊天Item
  _returnChatItem(i, item) {
    bool isMySelf = item['id'] == mySelf['id'];

    List<Widget> widgetList = [
      WPopupMenu(
          onValueChanged: (value) {
            _switchMenuValue(value, item);
          },
          menuHeight: ScreenUtil().setHeight(80),
          actions: ['复制', '转发', '收藏', '删除', '翻译'],
          child: LimitedBox(
            maxWidth:
                MediaQuery.of(context).size.width - ScreenUtil().setWidth(200),
            child: Bubble(
              padding: BubbleEdges.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                  horizontal: ScreenUtil().setWidth(20)),
              margin: isMySelf
                  ? BubbleEdges.only(top: 10, right: 10)
                  : BubbleEdges.only(top: 10, left: 10),
              nip: isMySelf ? BubbleNip.rightTop : BubbleNip.leftTop,
              color: isMySelf ? Color(0xFF9be34f) : Colors.white,
              child: Text(item['content'], textAlign: TextAlign.left),
            ),
          ))
    ];

    if (isMySelf) {
      // 本人的信息  true
      widgetList.add(CircleAvatar(
        radius: ScreenUtil().setWidth(38),
        backgroundImage: NetworkImage('${item['imageUrl']}'),
      ));
    } else {
      // 非本人的信息 false
      widgetList.insert(
          0,
          CircleAvatar(
            radius: ScreenUtil().setWidth(38),
            backgroundImage: NetworkImage('${item['imageUrl']}'),
          ));
    }

    return Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
        child: Row(
            mainAxisAlignment:
                isMySelf ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: []..addAll(widgetList)));
  }

  /// 筛选长按聊天Item的事件
  void _switchMenuValue(value, item) {
    switch (value) {
      case 0:
        Clipboard.setData(ClipboardData(text: item['content']));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFe7e7e7),
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: _chatHistory.length,
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(100),
                      left: ScreenUtil().setWidth(20)),
                  itemBuilder: (context, index) {
                    return _returnChatItem(index, _chatHistory[index]);
                  },
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
                                  _sendMessage(val, 'text');
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
