import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './detailed.dart';
import './contacts.dart';

class Index_Drawer extends StatefulWidget{
  @override
  Index_DrawerState createState() => new Index_DrawerState();
}

class Index_DrawerState extends State<Index_Drawer>{
  Map detail = {
    'name': '',
    'imageUrl': 'https://image.lingcb.net/default/goods/1080x0.jpg',
    'id': '',
    'lastTime': '',
    'backgroundUrl': 'https://image.lingcb.net/default/goods/1080x0.jpg',
  };

  getUserInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = json.decode(prefs.getString('userInfo'));
    setState(() {
      detail = data;
    });
  }

  initState(){
    getUserInfo();
  }

  @override
  Widget build(BuildContext context){

    return new Drawer(
        child: new Container(
          color: const Color(0xFF242329),
          child: new ListView(
            children: <Widget>[
              new Container(
                height: 200.0,
                child: new Stack(
                  children: <Widget>[
                    new Opacity(
                      opacity: 0.5,
                      child: new Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImage(detail['backgroundUrl']),
                            fit: BoxFit.fill
                          )
                        ),
                      )
                    ),
                    new Positioned(
                      top: 40,
                      child: new Container(
                        width: 300.0,
                        child: new Column(
                          children: <Widget>[
                            new GestureDetector(
                              child: new CircleAvatar(
                                radius: 35.0,
                                backgroundImage: new NetworkImage(detail['imageUrl']),
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (_){
                                    return new Detailed(detail: detail);
                                  })
                                );
                              },
                            ),
                            new Center(
                              child:  new Text(detail['name'], 
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  height: 1.5       
                                ),
                              ),
                            ),
                            new Center(
                              child:  new Text('如果我是Dj你会爱我吗?', 
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,   
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  ],
                )
              ),
              new ListTile(
                leading: Icon(Icons.chat_bubble_outline, color: Colors.white),
                title: new Text('WeChat' ,style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 15.0,
                  child: new Text('3'),
                  backgroundColor: const Color(0xFFf46464),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              new ListTile(
                leading: Icon(Icons.people_outline, color: Colors.white),
                title: new Text('Contacts', style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_){
                      return new Contacts();
                    })
                  );
                },
              ),
              new ListTile(
                leading: Icon(Icons.timeline, color: Colors.white),
                title: new Text('TimeLine' ,style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              new ListTile(
                leading: Icon(Icons.link, color: Colors.white),
                title: new Text('Collection',style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              new ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: new Text('setting',style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              new ListTile(
                leading: Icon(Icons.label_outline, color: Colors.white),
                title: new Text('SignOut',style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                      title: new Text('提示'),
                      content: new Text('你确定要退出吗?'),
                      actions: <Widget>[
                        OutlineButton(
                          child: new Text('取消'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        OutlineButton(
                          child: new Text('确定'),
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/signIn');
                          },
                        )
                      ],
                    )
                  );
                },
              )
            ],
          ),
        ),
      );
  }
}