import 'package:flutter/material.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FristPage extends StatefulWidget {
  FristPage({Key key}) : super(key: key);

  FristPageState createState() => FristPageState();
}

class FristPageState extends State<FristPage> {
  List<Slide> slides = [
    Slide(
      title: "杨宗纬 - 空白格",
      styleTitle: TextStyle(color: Color(0xFF333333)),
      description: "“其实很简单 其实很自然”",
      styleDescription: TextStyle(color: Color(0xFF333333)),
      pathImage: "images/yzw.jpg",
      backgroundColor: Color(0xffF5F6FA),
    ),
    Slide(
      title: "田馥甄 - 你就不要想起我",
      styleTitle: TextStyle(color: Color(0xFF333333)),
      description: "“只要你敢不懦弱 凭什么我们要错过”",
      styleDescription: TextStyle(color: Color(0xFF333333)),
      pathImage: "images/tfz.jpg",
      backgroundColor: Color(0xffF5F6FA),
    ),
    Slide(
      title: "周杰伦 - 晴天",
      styleTitle: TextStyle(color: Color(0xFF333333)),
      description: "“从前从前有个人爱你很久 但偏偏雨渐渐把距离吹得好远”",
      styleDescription: TextStyle(color: Color(0xFF333333)),
      pathImage: "images/zjl.jpg",
      backgroundColor: Color(0xffF5F6FA),
    ),
  ];

  void onDonePress() async {
    // 完成并引导页  跳转登录
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFristInstall', false);
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        slides: this.slides,
        styleNameSkipBtn: TextStyle(color: Color(0xFF333333)),
        styleNameDoneBtn: TextStyle(color: Color(0xFF333333)),
        styleNamePrevBtn: TextStyle(color: Color(0xFF333333)),
        onDonePress: this.onDonePress,
      ),
    );
  }
}
