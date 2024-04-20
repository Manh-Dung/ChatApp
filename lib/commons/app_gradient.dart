import 'package:flutter/cupertino.dart';
import 'package:vinhcine/commons/app_colors.dart';

class AppGradient {
  static final linearGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );
}
