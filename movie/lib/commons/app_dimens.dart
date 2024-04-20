import 'package:flutter/cupertino.dart';
import 'package:vinhcine/ui/components/app_context.dart';

class AppDimens {
  AppDimens._(); // this basically makes it so you can instantiate this class
  static BuildContext context = AppContext.navigatorKey.currentContext!;

  //TextFontSize
  static const double fontSmaller = 11.0;
  static const double fontMaxSmall = 10.0;
  static const double fontSmall = 12.0;
  static const double fontNormal = 14.0;
  static const double fontLarge = 16.0;
  static const double fontExtra = 18.0;

  //Common
  static const double appBarHeight = 48.0;
  static double width = MediaQuery.of(context).size.width;
  static double height = MediaQuery.of(context).size.height;
  static double S = width * 8 / 360;
  static double M = width * 16 / 360;
  static double L = width * 24 / 360;
  static double XL = width * 40 / 360;
  static double XXL = width * 56 / 360;
}
