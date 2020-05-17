import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_wechat/common/index.dart';

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = 'lang';

  @override
  Future<Locale> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(_selectedLocaleKey)) return null;

    var locale = preferences.getString(_selectedLocaleKey);
    CommonState.lang = locale;

    return localeFromString(locale);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();
    String lang = localeToString(locale);
    CommonState.lang = lang;

    await preferences.setString(_selectedLocaleKey, lang);
  }
}
