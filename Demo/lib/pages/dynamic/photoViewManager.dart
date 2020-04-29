import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import '../../components/statusView.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer({this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return StatusImage(
      error: Image.asset('images/failed_image.png'),
      imageSrc: url,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return PhotoView(
          imageProvider: imageProvider,
          maxScale: PhotoViewComputedScale.contained * 2.0,
          minScale: PhotoViewComputedScale.contained * 1.0,
          initialScale: PhotoViewComputedScale.contained,
          onTapUp: (_, __, ___) {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
