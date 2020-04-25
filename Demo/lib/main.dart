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
          primaryColorLight: Colors.white,
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(title: TextStyle(color: Colors.white)),
              color: Color(0xFF61ab32),
              iconTheme: IconThemeData(color: Colors.white)),
          primaryColor: Color(0xFF61ab32),
          accentColor: Colors.white,
          cursorColor: Color(0xFF61ab32),
          accentColorBrightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black45,
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.red,
          ),
          accentIconTheme: IconThemeData(color: Colors.white),
          toggleableActiveColor: Color(0xFF61ab32),
          buttonColor: Color(0xFF61ab32),
          buttonTheme: ButtonThemeData(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              buttonColor: Color(0xFF61ab32),
              splashColor: Colors.transparent),
          dividerColor: Color(0xFFededed),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white),
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
