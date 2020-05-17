import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CommonState {
  /// 是否第一次登录
  static bool isFristInstall;

  static int selectDrawerIndex = 0;

  static dynamic globalContext;

  static ThemeData themedata = ThemeData(
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
        color: Colors.white,
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
      scaffoldBackgroundColor: Colors.white);

  static String lang = 'zh';

  static Future init() async {
    final prefs = await SharedPreferences.getInstance();

    selectDrawerIndex = 0;
    isFristInstall = prefs.getBool('isFristInstall') ?? true;
  }
}
