import 'package:flutter/material.dart';

import '../configs/app_colors.dart';


class AppShadow {
  static final boxShadow = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 5,
      offset: Offset(0, 0),
    ),
  ];
}
