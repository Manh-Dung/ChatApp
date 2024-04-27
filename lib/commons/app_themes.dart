import 'package:flutter/material.dart';
import 'package:vinhcine/commons/app_text_styles.dart';

import '../configs/app_colors.dart';


class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: AppColors.primary,
    primarySwatch: Colors.blue,
    primaryTextTheme: TextTheme(labelLarge: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shadowColor: AppColors.shadowColor),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Poppins',
    focusColor: AppColors.primary,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none),
        fillColor: AppColors.primary.withOpacity(0.1),
        hintStyle: AppTextStyle.poppins16Medium,
        focusColor: AppColors.primary,
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
      selectedItemColor: AppColors.primary,
      selectedLabelStyle: AppTextStyle.poppins16Medium.copyWith(color: AppColors
          .textTint),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(color: AppColors.primary, size: 24),
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(
        color: AppColors.primary,
        size: 24,
      ),
      unselectedItemColor: AppColors.primary,
      unselectedLabelStyle: AppTextStyle.poppins12Medium.copyWith(color: AppColors
          .textDart),
    ),
  );
}
