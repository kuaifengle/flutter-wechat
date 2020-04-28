import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../main.dart';
import '../other/help.dart';

class IndexRightDrawer extends StatefulWidget {
  IndexRightDrawer({Key key}) : super(key: key);

  @override
  IndexRightDrawerState createState() => IndexRightDrawerState();
}

class IndexRightDrawerState extends State<IndexRightDrawer> {
  /// rightDrewer菜单数据
  List<Map<String, dynamic>> drawerList = [
    {
      'icon': Feather.users,
      'title': '发起群聊',
      'onTap': (context) {
        Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1), content: Text('功能还未开放...')));
        Navigator.of(context).pop();
      }
    },
    {
      'icon': Icons.center_focus_strong,
      'title': '扫一扫',
      'onTap': (context) async {
        String barcode = await scanner.scan();
        Navigator.of(context).pop();
        if (barcode != '') {
          Scaffold.of(context).showSnackBar(
              SnackBar(duration: Duration(seconds: 1), content: Text(barcode)));
        }
      }
    },
    {
      'icon': Icons.payment,
      'title': '收付款',
      'onTap': (context) {
        Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1), content: Text('功能还未开放...')));
        Navigator.of(context).pop();
      }
    },
    {
      'icon': Feather.help_circle,
      'title': '帮助与反馈',
      'onTap': (context) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return HelpPage();
        }));
      }
    },
  ];

  /// 返回所有的List
  List<Widget> _returnDrawerList(context) {
    List<Widget> widgetList = [];

    for (int i = 0; i < drawerList.length; i++) {
      Map item = drawerList[i];
      widgetList.add(ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        leading: Icon(item['icon'], color: Colors.white),
        title: Text(
          '${item['title']}',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.white),
        ),
        onTap: () {
          item['onTap'](context);
        },
      ));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SmartDrawer(
        widthPercent: 0.4,
        child: Container(
          color: Color(0xFF242329),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _returnDrawerList(context),
          ),
        ));
  }
}

class SmartDrawer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final String semanticLabel;

  ///new start
  final double widthPercent;

  ///new end
  const SmartDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,

    ///new start
    this.widthPercent = 0.7,
  })  : assert(
            widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }

    final double _width = MediaQuery.of(context).size.width * widthPercent;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}
