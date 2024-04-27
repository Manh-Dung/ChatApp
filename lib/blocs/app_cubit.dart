import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhcine/generated/l10n.dart';

import '../models/base/base_cubit.dart';

part 'app_state.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit() : super(WaitingForWarmingUp(), null);
  late SharedPreferences prefs;

  Future<Locale> getLanguageFromLocalStorage() async {
    prefs = await SharedPreferences.getInstance();

    ///Language
    String languageCode =
        prefs.getString('languageCode') ?? window.locale.languageCode;
    var locale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => Locale.fromSubtags(languageCode: 'en'),
    );
    return locale;
  }

  void fetchData() async {
    var currentLocale = await getLanguageFromLocalStorage();
    var currentTheme = await getThemeFromLocalStorage();
    emit(FetchedFullDataSuccessfully(
        token: FirebaseAuth.instance.currentUser,
        currentLocale: currentLocale,
        currentTheme: currentTheme));
  }

  void fetchAppLanguage() async {
    emit(WaitingForFetchingLanguage());

    ///Language
    var currentLocale = await getLanguageFromLocalStorage();
    emit(FetchedLanguageSuccessfully(currentLocale: currentLocale));
  }

  void fetchAppTheme() async {
    emit(WaitingForFetchingTheme());

    ///Theme
    var currentTheme = await getThemeFromLocalStorage();
    emit(FetchedThemeSuccessfully(currentTheme: currentTheme));
  }

  Future<ThemeMode> getThemeFromLocalStorage() async {
    prefs = await SharedPreferences.getInstance();

    ///Theme
    String themeModeCode = prefs.getString("themeCode") ?? ThemeMode.light.code;
    final themeMode = ThemeModeExtension.fromCode(themeModeCode);
    // currentThemeMode.value = themeMode;
    // String languageCode = prefs.getString('languageCode') ?? window.locale.languageCode;
    // var locale = S.delegate.supportedLocales.firstWhere(
    //       (element) => element.languageCode == languageCode,
    //   orElse: () => Locale.fromSubtags(languageCode: 'en'),
    // );
    return themeMode;
  }

  void updateLocale(Locale locale) {
    prefs.setString('languageCode', locale.languageCode);
    emit(ChangedLanguageSuccessfully(currentLocale: locale));
  }

  void updateTheme(ThemeMode themeMode) {
    prefs.setString('themeCode', themeMode.code);
    emit(ChangedThemeSuccessfully(currentTheme: themeMode));
  }
}

extension ThemeModeExtension on ThemeMode {
  String get code {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  static ThemeMode fromCode(String code) {
    switch (code) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
