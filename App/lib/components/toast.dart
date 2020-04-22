import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './loading.dart';

// ======================================  轻提示  ======================================
/// 轻提示
class Toast {
  static const int BOTTOM = 0;
  static const int CENTER = 1;
  static const int TOP = 2;

  static void show(String msg, BuildContext context,
      {int duration,
      int gravity,
      Color backgroundColor,
      Color textColor,
      int backgroundRadius,
      Border border,
      int fontSize}) {
    ToastView?.dismiss();
    ShowLoading?.dismiss();
    ToastView.createView(msg, context, duration, gravity, backgroundColor,
        textColor, backgroundRadius, border, fontSize);
  }
}

class ToastView {
  static final ToastView _singleton =  ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,
      BuildContext context,
      int duration,
      int gravity,
      Color background,
      Color textColor,
      int backgroundRadius,
      Border border,
      int fontSize) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    _overlayEntry =  OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
        widget: InkWell(
          onTap: dismiss,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(backgroundRadius),
                  ),
                  border: border,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Text(
                  msg,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(fontSize),
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        gravity: gravity,
      ),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    if (duration != 0) {
      await  Future.delayed(Duration(seconds: duration));
      dismiss();
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return  Positioned(
        top: gravity == 2 ? 50 : null,
        bottom: gravity == 0 ? 50 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}

// ======================================  显示加载框  ======================================

/// 显示加载框      msg 加载Text      duration 秒数
class ShowLoading {
  static void show(BuildContext context, {String msg, int duration}) {
    ToastView?.dismiss();
    ShowLoadingView?.dismiss();
    ShowLoadingView.createView(context, msg, duration);
  }

  static void dismiss() {
    ShowLoadingView.dismiss();
  }
}

class ShowLoadingView {
  static final ShowLoadingView _singleton =  ShowLoadingView._internal();

  factory ShowLoadingView() {
    return _singleton;
  }

  ShowLoadingView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(BuildContext context, String msg, int duration) async {
    overlayState = Overlay.of(context);

    _overlayEntry =  OverlayEntry(
        builder: (BuildContext context) => Material(
              color: Colors.black45,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(20))),
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setWidth(200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Loading(),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                        child: Text(
                          msg,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    if (duration != null && duration != 0) {
      await  Future.delayed(Duration(seconds: duration));
      dismiss();
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}
