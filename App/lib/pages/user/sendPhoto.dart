import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendPhoto extends StatefulWidget{
  @override
  _SendPhotoState createState() => new _SendPhotoState();
}

class _SendPhotoState extends State<SendPhoto>{
  var textController = new TextEditingController();
  var fsNode = new FocusNode();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black45),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            child: new Text('发表', style: new TextStyle(
              color: new Color(0xFF64c223),
              fontWeight: FontWeight.bold
            )),
            onPressed: () {
              print('发表文字');
            },
          )
        ],
      ),
      body: new Container(
        child: ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: new TextField(
              focusNode: fsNode,
              controller: textController,
              decoration: new InputDecoration(
                hintText: '这一刻的想法...',
                border: InputBorder.none
              ),
              keyboardType: TextInputType.text,
              maxLines: 6,
              onSubmitted: (value){
                fsNode.unfocus();
              },
            ),
          ),
          new SelectPhoto(),
          new ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: new Text('所在位置')
          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new ListTile(
            leading: Icon(Icons.people),
            title: new Text('谁可以看'),

          ),
          new Divider(height: 2.0, color: Color(0xFFededed)),
          new ListTile(
            leading: Icon(Icons.insert_link),
            title: new Text('提现谁看')
          ),
        ],
      ),
      )
    );
  }
}


class SelectPhoto extends StatefulWidget{
  @override
  SelectPhotoState createState() => new SelectPhotoState();
}

class SelectPhotoState extends State<SelectPhoto>{

List photoList = [];
Widget selectPhotoWidget;

getWrapList() {
  var width = (MediaQuery.of(context).size.width - 40) / 3;

 List warpList = <Widget>[];
  for(var i = 0; i < photoList.length; i++) {
    if (photoList.length <= 9 ) {
        warpList.add(
          new GestureDetector(
            child: new Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: Color(0xFFededed),
              ),
              child: new Center(
                child:  photoList[i],
              )
            ),
            onTap: (){
              photoList.removeAt(i);
              getWrapList();
            },
          )
        );
    } else {
      return;
    }
  }       
  if (photoList.length != 9 || photoList.length == 0) {
    warpList.add(
      new GestureDetector(
        child: new Container(
          width: width,
          height: width,
          decoration: new BoxDecoration(
            color: Color(0xFFcccccc),
          ),
          child: new Center(
            child:  new Icon(Icons.add,size: 50.0),
          )
        ),
        onTap: (){
          // photoList.insert(photoList.length, photoList.length);
          openImage();
        },
      )
    );
  }

  selectPhotoWidget = Builder(
    
    builder: (context) {
     return Wrap(
        alignment: WrapAlignment.start,
        spacing: 10.0,
        runSpacing: 10.0,
        children: warpList
      );
    },
  );

  setState(() {
    selectPhotoWidget = selectPhotoWidget;
  });
}

Future openImage() async{
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  
  if (image != null) {
    photoList.insert(photoList.length, new Image.file(image));
    getWrapList();
  }
}

  Widget build(BuildContext context){
  getWrapList();
    return new Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      child: selectPhotoWidget
    );
  }

}