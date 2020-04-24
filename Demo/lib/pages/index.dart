import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import './index/leftDrawer.dart';
import './home.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  IndexState createState() => IndexState();
}

class IndexState extends State<Index> with SingleTickerProviderStateMixin {
  bool isLeft = true;
  final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  Widget build(BuildContext context) {
    return InnerDrawer(
      key: innerDrawerKey,
      onTapClose: false,
      tapScaffoldEnabled: false,
      offset: IDOffset.horizontal(0.65),
      swipe: true,
      boxShadow: null,
      colorTransition: Colors.black54,
      leftAnimationType: InnerDrawerAnimation.static,
      leftChild: IndexLeftDrawer(),
      scaffold: Home(innerDrawerKey: innerDrawerKey),
      onDragUpdate: (double i, InnerDrawerDirection dir) {},
    );
  }
}
