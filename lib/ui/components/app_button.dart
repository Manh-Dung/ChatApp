import 'package:flutter/material.dart';
import 'package:vinhcine/commons/app_shadow.dart';
import 'package:vinhcine/ui/widgets/loading_indicator_widget.dart';

import '../../configs/app_colors.dart';

class _AppButton extends StatelessWidget {
  String? title;
  bool? isLoading;
  VoidCallback? onPressed;

  Color? textColor;
  Color? backgroundColor;

  _AppButton({
    this.title,
    this.isLoading,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: EdgeInsets.all(0),
        child: TextButton(
          child: _buildBodyWidget(),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
          onPressed: onPressed,
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: AppShadow.boxShadow,
      ),
    );
  }

  Widget _buildBodyWidget() {
    if (isLoading ?? true) {
      return LoadingIndicatorWidget(color: Colors.white);
    } else {
      return Text(
        title ?? "",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      );
    }
  }
}

class AppWhiteButton extends _AppButton {
  AppWhiteButton({
    String title = '',
    bool isLoading = false,
    VoidCallback? onPressed,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    //SetupUI
    textColor = AppColors.primary;
    backgroundColor = Colors.white;
  }
}

class AppTintButton extends _AppButton {
  AppTintButton({
    String title = '',
    bool isLoading = false,
    VoidCallback? onPressed,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    //SetupUI
    textColor = Colors.white;
    backgroundColor = AppColors.primary;
  }
}
