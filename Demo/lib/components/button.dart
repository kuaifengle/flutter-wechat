import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// =================================================
//  背景透明 - 文本按钮
class TextButton extends StatefulWidget {
  TextButton(
      {Key key,
      @required this.text,
      this.textColor,
      this.fontSize,
      this.bgColor,
      this.padding,
      @required this.onPressed})
      : super(key: key);
  final text;
  final Color textColor;
  final Color bgColor;
  final padding;
  final num fontSize;
  final Function onPressed;

  _TextButtonState createState() =>  _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: widget.padding ??
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        child: Center(
          child:  Text(widget.text,
              maxLines: 1,
              style:  TextStyle(
                  decoration: TextDecoration.none,
                  decorationColor: Colors.transparent,
                  color: widget.textColor ?? Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(
                    widget.fontSize ?? 30,
                  ))),
        ),
        color: widget.bgColor ?? Colors.transparent,
      ),
      onTap: widget.onPressed,
    );
  }
}