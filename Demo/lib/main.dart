import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_wechat/common/index.dart';
import 'package:flutter_wechat/utils/translatePreferences.dart';
import './pages/fristPage.dart';
import './pages/index.dart';
import './pages/sign/signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 数据初始化
  await CommonState.init();
  print(CommonState.lang);

  /// i18n初始化
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: CommonState.lang,
      preferences: TranslatePreferences(),
      supportedLocales: ['en', 'zh']);

  runApp(LocalizedApp(delegate, MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Wechat',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: CommonState.themedata,
        home: Stack(
          children: <Widget>[FlutterWechat()],
        ),
        routes: {
          '/home': (_) => Index(),
          '/signIn': (_) => SignIn(),
        },
      ),
    );
  }
}

/// 判断是第一次安装还是跳转home
class FlutterWechat extends StatelessWidget {
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return CommonState.isFristInstall ? FristPage() : Index();
  }
}
