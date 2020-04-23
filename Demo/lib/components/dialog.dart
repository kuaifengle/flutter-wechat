import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './toast.dart';

class UtilDialog {
  /// 消息提示框
  /// duration 提示信息关闭倒计时 单位：秒 默认点击关闭  默认值：0 if position != 'Center' && duration == 0 => duration = 2
  /// backgroundColor 提示框背景色  默认值：黑色 60%透明度
  /// backgroundRadius 提示框圆角  默认值：8
  /// textColor 提示文本色 默认值：白色
  /// fontSize 提示信息字体大小 默认值：24
  /// position 提示框显示的位置 "Top"：顶部  "Center"：中间  "Bottom"：底部  默认值：Center
  static void showMessage(context, String msg,
      {int duration = 0,
      Color backgroundColor,
      int backgroundRadius = 8,
      Color textColor = Colors.white,
      Border border,
      int fontSize = 24,
      String position = 'Bottom'}) {
    final Map<String, dynamic> positionList = {
      'Top': Toast.TOP,
      'Center': Toast.CENTER,
      'Bottom': Toast.BOTTOM,
    };
    // 如果提示信息不是中间，则强制设置关闭响应
    if (position != 'Center' && duration == 0) {
      duration = 2;
    }
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: positionList[position],
      backgroundColor: backgroundColor ?? Color.fromRGBO(0, 0, 0, 0.6),
      backgroundRadius: backgroundRadius,
      textColor: textColor,
      border: border,
      fontSize: fontSize,
    );
  }

  /// 底部弹出提示框
  static void showBottomSheet(BuildContext context, List<Widget> actions) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: actions.map((res) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(25)),
                  decoration: actions.last == res
                      ? null
                      : BoxDecoration(
                          border: BorderDirectional(
                            bottom: BorderSide(
                              width: ScreenUtil().setHeight(1),
                              color: Color(0xFFeeeeee),
                            ),
                          ),
                        ),
                  child: res,
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  /// 确认框
  static void showConfirm(BuildContext context,
      {String title,
      String content,
      Function successFn,
      Function cancelFn,
      bool isDismissible = true}) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title ?? '提示',
              style: TextStyle(color: Color(0xFF333333), fontSize: 18),
            ),
            content: Text(
              content,
              style: TextStyle(color: Color(0xFF333333), fontSize: 14),
            ),
            contentPadding: EdgeInsets.all(15),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  if (cancelFn == null) {
                    Navigator.of(context).pop();
                  } else {
                    cancelFn();
                  }
                },
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  successFn();
                },
              ),
            ],
          );
        });
  }

  /// loading
  static void showLoading(context, {String msg = '加载中...'}) {
    ShowLoading.show(context, msg: msg);
  }

  /// 销毁loading
  static void disposeLoading() {
    ShowLoading.dismiss();
  }

  /// 日期选择控件
  static void showDateDialog(BuildContext context,
      {String value,
      String start,
      String end,
      Function changed,
      DatePickerMode mode}) {
    showDatePicker(
      context: context,
      initialDate: value == '' ? DateTime.now() : DateTime.parse(value),
      firstDate: start == '' ? DateTime(1900) : DateTime.parse(start),
      lastDate: end == '' ? DateTime(1900) : DateTime.parse(end),
      initialDatePickerMode: mode ?? DatePickerMode.day,
    ).then((picker) {
      if (picker != null) {
        changed(picker.toString());
      }
    });
  }
}
