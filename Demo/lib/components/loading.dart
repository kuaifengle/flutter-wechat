import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Loading加载状态
class Loading extends StatelessWidget {
  final int width;
  final int borderWidth;
  final Color color;
  Loading({this.width = 60, this.borderWidth = 6, this.color = Colors.black45});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ScreenUtil().setWidth(this.width),
        height: ScreenUtil().setWidth(this.width),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color),
          strokeWidth: ScreenUtil().setWidth(this.borderWidth),
        ),
      ),
    );
  }
}
