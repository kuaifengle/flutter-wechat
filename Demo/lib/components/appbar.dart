import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

setCustomAppBar(BuildContext context, String title,
    {Color backgroundColor,
    Color textColor,
    Color iconColor,
    List<Widget> actions,
    Widget leading,
    Function onPop}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(ScreenUtil().setHeight(90)),
    child: Container(
        child: AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: 0.0,
      leading: leading ??
          IconButton(
            alignment: Alignment.centerLeft,
            iconSize: ScreenUtil().setSp(38),
            icon: Icon(
              Icons.arrow_back_ios,
              color: iconColor,
            ),
            onPressed: onPop ??
                () {
                  Navigator.of(context).maybePop();
                },
          ),
      title: Text(
        title,
        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: textColor),
      ),
      actions: actions ?? [],
      centerTitle: true,
    )),
  );
}
