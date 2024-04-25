import 'package:flutter/material.dart';
import 'package:vinhcine/commons/app_text_styles.dart';

import '../configs/app_colors.dart';


class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: AppColors.main,
    primarySwatch: Colors.blue,
    primaryTextTheme: TextTheme(labelLarge: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shadowColor: AppColors.shadowColor),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.main,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Muli',
    focusColor: AppColors.main,
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
        fillColor: AppColors.main.withOpacity(0.1),
        hintStyle: AppTextStyle.roboto16Medium,
        focusColor: AppColors.main,
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
      selectedItemColor: AppColors.main,
      selectedLabelStyle: AppTextStyle.roboto16Medium.copyWith(color: AppColors.textTint),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(color: AppColors.main, size: 24),
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(
        color: AppColors.main,
        size: 24,
      ),
      unselectedItemColor: AppColors.main,
      unselectedLabelStyle: AppTextStyle.roboto12Medium.copyWith(color: AppColors.textDart),
    ),
  );
}
