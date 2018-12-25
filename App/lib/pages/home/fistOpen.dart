import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import './fistPage.dart';

class FirstOpen extends StatefulWidget {
  @override
  _FirstOpenState createState() => new _FirstOpenState();
}


class _FirstOpenState extends State<FirstOpen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "FLUTTER",
        description:
            "这是模仿的微信App, 纯属用于个人学习参考, 切勿用于商业用途",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xff409EFF),
      ),
    );
    slides.add(
      new Slide(
        title: "DART",
        description:
            "这是模仿的微信App, 纯属用于个人学习参考, 切勿用于商业用途",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xffE6A23C),
      ),
    );
    slides.add(
      new Slide(
        title: "WELECOME",
        description:
            "Open WeChat",
        pathImage: 'assets/images/logo.png',
        backgroundColor: Color(0xff909399),
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
        (route) => route == null
    );
  }

  void onSkipPress() {
    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
        (route) => route == null
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}