import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double? borderRadius;

  AppCacheImage({this.url, this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 48,
      height: height ?? 48,
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: url ?? '',
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Container(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(value: downloadProgress.progress),
            );
          },
          errorWidget: (context, url, error) {
            return Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white,
              size: width ?? 0 / 2,
            );
          },
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    );
  }
}
