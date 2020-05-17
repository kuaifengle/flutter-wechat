import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading.dart';

/// 拥有Loading的圆角头像
class StatusHeaderImage extends StatelessWidget {
  /// 宽度
  final int width;

  /// 高度
  final int height;

  /// 圆角
  final int radius;

  /// 图片链接
  final String imageSrc;

  final bool needBorder;

  StatusHeaderImage(
      {this.imageSrc,
      this.width,
      this.height,
      this.radius,
      this.needBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(this.width),
      height: ScreenUtil().setWidth(this.height),
      decoration: needBorder
          ? BoxDecoration(
              border: Border.all(
                  color: Colors.white, width: ScreenUtil().setWidth(4)),
              borderRadius:
                  BorderRadius.circular(ScreenUtil().setWidth(this.width / 2)))
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(this.radius)),
        child: this.imageSrc != null && this.imageSrc != ''
            ? StatusImage(
                imageSrc: this.imageSrc,
                width: ScreenUtil().setWidth(this.width),
                height: ScreenUtil().setWidth(this.height),
                fit: BoxFit.cover,
                error: Image.asset('assets/images/user_sex_unknow.png'))
            : Image.asset(
                'assets/images/user_sex_unknow.png',
                width: ScreenUtil().setWidth(this.width),
                height: ScreenUtil().setWidth(this.height),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

/// 拥有状态的Image
class StatusImage extends StatelessWidget {
  /// 宽度
  final double width;

  /// 高度
  final double height;

  /// 图片链接
  final String imageSrc;

  /// 填充方式
  final BoxFit fit;

  /// 报错图片
  final Widget error;

  /// imageBuilder
  final Function imageBuilder;

  StatusImage(
      {this.imageSrc,
      this.width,
      this.height,
      this.fit,
      this.error,
      this.imageBuilder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: Alignment.center,
      width: this.width,
      height: this.height,
      fit: this.fit ?? BoxFit.cover,
      imageUrl: this.imageSrc,
      imageBuilder: imageBuilder != null
          ? (context, imageProvider) {
              return imageBuilder(context, imageProvider);
            }
          : null,
      placeholder: (BuildContext context, String url) {
        return Loading(
          borderWidth: 3,
          color: Colors.white,
        );
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return this.error;
      },
    );
  }
}
