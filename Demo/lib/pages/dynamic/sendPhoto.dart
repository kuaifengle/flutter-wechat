import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../components/button.dart';
import '../../components/appbar.dart';

class SendPhoto extends StatefulWidget {
  @override
  _SendPhotoState createState() => _SendPhotoState();
}

class _SendPhotoState extends State<SendPhoto> {
  var _textController = TextEditingController();
  var _fsNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(
          context,
          '',
          actions: <Widget>[
            TextButton(
              text: translate('dynamic.create'),
              onPressed: () {
                print('发表文字');
              },
            )
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: ScreenUtil().setHeight(2),
                            color: Color(0xFFebebeb)))),
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  focusNode: _fsNode,
                  controller: _textController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: ScreenUtil().setSp(30)),
                      hintText: translate('dynamic.sendPlaceholder'),
                      border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  onSubmitted: (value) {
                    _fsNode.unfocus();
                  },
                ),
              ),
              SelectPhoto(),
              ListTile(
                  leading:
                      Icon(Feather.map_pin, size: ScreenUtil().setWidth(40)),
                  title: Text('所在位置',
                      style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: ScreenUtil().setSp(22)))),
              Divider(height: 2.0),
              ListTile(
                leading: Icon(Feather.link, size: ScreenUtil().setWidth(40)),
                title: Text('谁可以看',
                    style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: ScreenUtil().setSp(22))),
              ),
              Divider(height: 2.0),
              ListTile(
                  leading: Icon(Feather.flag, size: ScreenUtil().setWidth(40)),
                  title: Text('提现谁看',
                      style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: ScreenUtil().setSp(22)))),
              Divider(height: 2.0),
            ],
          ),
        ));
  }
}

class SelectPhoto extends StatefulWidget {
  @override
  SelectPhotoState createState() => SelectPhotoState();
}

class SelectPhotoState extends State<SelectPhoto> {
  List photoList = [];
  Widget selectPhotoWidget;

  getWrapList() {
    var width = (MediaQuery.of(context).size.width - 40) / 3;

    List warpList = <Widget>[];
    for (var i = 0; i < photoList.length; i++) {
      if (photoList.length <= 9) {
        warpList.add(GestureDetector(
          child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: Color(0xFFededed),
              ),
              child: Center(
                child: photoList[i],
              )),
          onTap: () {
            photoList.removeAt(i);
            getWrapList();
          },
        ));
      } else {
        return;
      }
    }
    if (photoList.length != 9 || photoList.length == 0) {
      warpList.add(GestureDetector(
        child: Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Color(0xFFcccccc),
            ),
            child: Center(
              child: Icon(Icons.add, size: 50.0),
            )),
        onTap: () {
          // photoList.insert(photoList.length, photoList.length);
          openImage();
        },
      ));
    }

    selectPhotoWidget = Builder(
      builder: (context) {
        return Wrap(
            alignment: WrapAlignment.start,
            spacing: 10.0,
            runSpacing: 10.0,
            children: warpList);
      },
    );

    setState(() {
      selectPhotoWidget = selectPhotoWidget;
    });
  }

  openImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      photoList.insert(photoList.length, Image.file(image));
      getWrapList();
    }
  }

  Widget build(BuildContext context) {
    getWrapList();
    return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: selectPhotoWidget);
  }
}
