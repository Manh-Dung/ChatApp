import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinhcine/commons/app_colors.dart';
import 'package:vinhcine/commons/app_dimens.dart';
import 'package:vinhcine/commons/app_images.dart';
import 'package:vinhcine/commons/app_text_styles.dart';

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
            style: AppTextStyle.roboto18W800.copyWith(color: AppColors.background),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.main,
      ),
    );
  }
}
