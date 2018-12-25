import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../user/sendPhoto.dart';
import '../user/timeLine.dart';
import '../user/searhFriend.dart';

class MenuFloatButton extends StatefulWidget{
  @override
  MenuFloatButtonState createState() => new MenuFloatButtonState();
}

class MenuFloatButtonState extends State<MenuFloatButton> {
  bool btnShow = true;
  Map mySelf = {};

  @override
  void initState() {
    super.initState();
    getMySelf();
    
  }
  getMySelf() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mySelf = json.decode(prefs.getString('userInfo'));
  }

  Widget build(BuildContext context){
      return Positioned(
        right: 20,
        bottom: 20,
          child:  new Container(
          width: 120.0,
          height: 120.0,
          child:  new Stack(
              children: <Widget>[
                new Positioned(
                  width: 50.0,
                  height: 50.0,
                  bottom: 0,
                  right: 0,
                  child: Transform.rotate(
                    child: new FloatingActionButton(
                      child: new Icon(Icons.add),
                      backgroundColor: const Color(0xFF6f69c1),
                      onPressed: (){
                        setState(() {
                          btnShow = !btnShow;
                        });
                      },
                    ),
                    angle: !btnShow ? 0.8 : 0,
                  )
                ),
                new Positioned(
                  width: 42.0,
                  height: 42.0,
                  bottom: 0,
                  left: 0,
                  child: new Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.camera),
                          color: const Color(0xFFffffff),
                          onPressed: (){
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (_) => new TimeLine(detail: mySelf)
                              )
                            );
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )
                  ),
                ),
                new Positioned(
                  width: 42.0,
                  height: 42.0,
                  top: 25.0,
                  left: 25.0,
                  child: new Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.person_add),
                          color: const Color(0xFFffffff),
                          onPressed: (){
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (_) => new SearchFriendPage()
                              )
                            );
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )
                  ),
                ),
                new Positioned(
                  width: 42.0,
                  height: 42.0,
                  top: 0,
                  right: 0,
                  child: new Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: new IconButton(
                          icon: new Icon(Icons.photo_camera),
                          color: const Color(0xFFffffff),
                          onPressed: (){
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (_) => new SendPhoto()
                              )
                            );
                          },
                        ),
                        backgroundColor: const Color(0xFF6f69c1),
                      ),
                    )
                  ),
                ),
              ],
            )),
        );
  }
}