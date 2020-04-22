import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

// =================================================
//  背景透明 - svg按钮
class SvgButton extends StatefulWidget {
  SvgButton(
      {Key key,
      this.width,
      this.icon,
      this.color,
      this.padding,
      this.iconWidth,
      @required this.onPressed})
      : super(key: key);

  /// icon的名称  images/svg/目录下要存在
  final String icon;
  final int width;
  final int iconWidth;
  final Color color;
  final EdgeInsets padding;
  final Function onPressed;

  SvgButtonState createState() =>  SvgButtonState();
}

class SvgButtonState extends State<SvgButton> {
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(widget.width ?? 80),
      width: ScreenUtil().setHeight(widget.width ?? 80),
      child: IconButton(
        padding: widget.padding ?? EdgeInsets.all(ScreenUtil().setWidth(0)),
        icon: SvgPicture.asset(
          'images/svg/' + widget.icon + '.svg',
          color: widget.color ?? Color(0xFF333333),
          height: ScreenUtil().setHeight(widget.iconWidth ?? 36),
          width: ScreenUtil().setHeight(widget.iconWidth ?? 36),
          fit: BoxFit.cover,
        ),
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
