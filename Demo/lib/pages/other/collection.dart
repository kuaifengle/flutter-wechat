import 'package:flutter/material.dart';

import '../../components/appbar.dart';

class Collection extends StatefulWidget {
  Collection({
    Key key,
  }) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCustomAppBar(
          context,
          '我的收藏',
        ),
        body: Container(child: Text('收藏')));
  }
}
