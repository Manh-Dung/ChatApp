import 'package:flutter/material.dart';

class ScreenSize {
  double width = 0;
  double height = 0;
  double topPadding = 0;
  double bottomPadding = 0;

  ScreenSize.of(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    topPadding = _mediaQueryData.padding.top;
    bottomPadding = _mediaQueryData.padding.bottom;
  }
}
