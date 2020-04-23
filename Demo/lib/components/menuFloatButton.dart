import 'package:flutter/material.dart';

import '../pages/dynamic/sendPhoto.dart';
import '../pages/dynamic/timeLine.dart';
import '../pages/contacts/searhFriend.dart';

class MenuFloatButton extends StatefulWidget {
  @override
  MenuFloatButtonState createState() => MenuFloatButtonState();
}

class MenuFloatButtonState extends State<MenuFloatButton> {
  bool btnShow = true;

  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Container(
          width: 120.0,
          height: 120.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                  width: 50.0,
                  height: 50.0,
                  bottom: 0,
                  right: 0,
                  child: Transform.rotate(
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Color(0xFF6f69c1),
                      onPressed: () {
                        setState(() {
                          btnShow = !btnShow;
                        });
                      },
                    ),
                    angle: !btnShow ? 0.8 : 0,
                  )),
              Positioned(
                width: 42.0,
                height: 42.0,
                bottom: 0,
                left: 0,
                child: Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.camera),
                          color: Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => TimeLine()));
                          },
                        ),
                        backgroundColor: Color(0xFF6f69c1),
                      ),
                    )),
              ),
              Positioned(
                width: 42.0,
                height: 42.0,
                top: 25.0,
                left: 25.0,
                child: Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.person_add),
                          color: Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SearchFriendPage()));
                          },
                        ),
                        backgroundColor: Color(0xFF6f69c1),
                      ),
                    )),
              ),
              Positioned(
                width: 42.0,
                height: 42.0,
                top: 0,
                right: 0,
                child: Visibility(
                    visible: !btnShow,
                    child: Center(
                      child: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.photo_camera),
                          color: Color(0xFFffffff),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => SendPhoto()));
                          },
                        ),
                        backgroundColor: Color(0xFF6f69c1),
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
