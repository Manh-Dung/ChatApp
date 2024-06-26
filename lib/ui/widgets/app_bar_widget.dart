import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../commons/app_dimens.dart';
import '../../commons/app_images.dart';
import '../../commons/app_text_styles.dart';
import '../../configs/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final String? title;

  AppBarWidget({this.onBackPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.appBarHeight,
      child: Row(
        children: [
          SizedBox(width: 14),
          GestureDetector(
            child: onBackPressed != null
                ? Container(
                    width: 44,
                    height: 44,
                    child: Image.asset(AppImages.icWhiteBack),
                  )
                : SizedBox(width: 6),
            onTap: onBackPressed,
          ),
          SizedBox(width: 2),
          Text(
            title ?? "",
            style:
                AppTextStyle.poppins18W800.copyWith(color: AppColors.white),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
      ),
    );
  }
}
