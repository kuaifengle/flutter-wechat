import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_wechat/common/index.dart';
import './pages/fristPage.dart';
import './pages/index.dart';
import './pages/sign/signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CommonState.init();

  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Wechat',
      theme: ThemeData(
          platform: TargetPlatform.iOS,
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Color(0xFF61ab32),
              iconTheme: IconThemeData(color: Colors.white)),
          primaryColor: Color(0xFF61ab32),
          iconTheme: IconThemeData(
            color: Color(0xFF7b7c77),
          )),
      home: Stack(
        children: <Widget>[FlutterWechat()],
      ),
      routes: {
        '/home': (_) => Index(),
        '/signIn': (_) => SignIn(),
      },
    );
  }
}

class FlutterWechat extends StatelessWidget {
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return CommonState.isFristInstall ? FristPage() : Index();
  }
}
