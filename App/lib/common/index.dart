import 'package:shared_preferences/shared_preferences.dart';

class CommonState {
  /// 是否第一次登录
  static bool isFristInstall;

  static int selectDrawerIndex = 0;

  static dynamic globalContext;

  static Future init() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isFristInstall'));

    isFristInstall = prefs.getBool('isFristInstall') ?? true;
  }
}
