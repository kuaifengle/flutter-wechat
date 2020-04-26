import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import './contacts/contactsList.dart';
import './drawer/rightDrawer.dart';
import '../components/appbar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.innerDrawerKey}) : super(key: key);

  final GlobalKey<InnerDrawerState> innerDrawerKey;

  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: setCustomAppBar(context, 'WeChat',
          actions: <Widget>[
            IconButton(
              icon: Icon(Feather.plus),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Feather.list),
            onPressed: () {
              widget.innerDrawerKey.currentState.toggle();
            },
          )),
      endDrawer: IndexRightDrawer(),
      body: Contacts(),
    );
  }
}
