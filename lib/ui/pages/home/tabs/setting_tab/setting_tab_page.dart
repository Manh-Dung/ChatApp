import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/blocs/app_cubit.dart';
import 'package:vinhcine/commons/app_dimens.dart';
import 'package:vinhcine/commons/app_text_styles.dart';
import 'package:vinhcine/configs/di.dart';
import 'package:vinhcine/generated/l10n.dart';
import 'package:vinhcine/main.dart';
import 'package:vinhcine/router/routers.dart';
import 'package:vinhcine/ui/components/app_button.dart';
import 'package:vinhcine/ui/pages/sign_in/cubit/auth_cubit.dart';
import 'package:vinhcine/ui/widgets/app_bar_widget.dart';
import 'package:vinhcine/ui/widgets/customized_scaffold_widget.dart';
import 'package:vinhcine/ui/widgets/debounce_gesture_detector.dart';

class SettingTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingTabPageState();
  }
}

class _SettingTabPageState extends State<SettingTabPage> {
  final AuthCubit _cubit = getIt<AuthCubit>();
  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  void initState() {
    super.initState();
    _appCubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
      appBar: AppBarWidget(title: S.of(context).setting),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        _buildLanguageSection(),
        _buildThemeSection(),
        SizedBox(height: AppDimens.L),
        _buildSignOutButton(),
      ],
    );
  }

  Widget _buildSignOutButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.loading) {
          showLoading();
        } else if (state.authStatus == AuthStatus.initial) {
          hideLoading();
        } else if (state.authStatus == AuthStatus.failure) {
          hideLoading();
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimens.M),
          child: AppTintButton(
            title: S.of(context).logout,
            isLoading: state.authStatus == AuthStatus.loading,
            onPressed: _handleSignOut,
          ),
        );
      },
    );
  }

  Widget _buildLanguageSection() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: AppDimens.M, top: AppDimens.M),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).setting_language,
                style: AppTextStyle.poppins18Medium,
              ),
              SizedBox(height: AppDimens.S),
              DebounceGestureDetector(
                onTap: () {
                  _appCubit
                      .updateLocale(Locale.fromSubtags(languageCode: 'en'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio<Locale>(
                          value: Locale.fromSubtags(languageCode: 'en'),
                          groupValue: state.currentLocale,
                          onChanged: (Locale? value) {
                            if (value != null) {
                              _appCubit.updateLocale(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).english,
                          style: AppTextStyle.poppins16Regular
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              DebounceGestureDetector(
                onTap: () {
                  _appCubit
                      .updateLocale(Locale.fromSubtags(languageCode: 'vi'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio<Locale>(
                          value: Locale.fromSubtags(languageCode: 'vi'),
                          groupValue: state.currentLocale,
                          onChanged: (Locale? value) {
                            if (value != null) {
                              _appCubit.updateLocale(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).vietnamese,
                          style: AppTextStyle.poppins16Regular
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeSection() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (prev, current) {
        return current is ChangedThemeSuccessfully ||
            current is FetchedThemeSuccessfully;
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: AppDimens.M, top: AppDimens.M),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).setting_theme,
                style: AppTextStyle.poppins18Medium,
              ),
              SizedBox(height: AppDimens.S),
              DebounceGestureDetector(
                onTap: () {
                  _appCubit.updateTheme(ThemeMode.light);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio<ThemeMode>(
                          value: ThemeMode.light,
                          groupValue: state.currentTheme,
                          onChanged: (ThemeMode? value) {
                            if (value != null) {
                              _appCubit.updateTheme(ThemeMode.light);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(S.of(context).light,
                          style: AppTextStyle.poppins16Regular
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              DebounceGestureDetector(
                onTap: () {
                  _appCubit.updateTheme(ThemeMode.dark);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio<ThemeMode>(
                          value: ThemeMode.dark,
                          groupValue: state.currentTheme,
                          onChanged: (ThemeMode? value) {
                            if (value != null) {
                              _appCubit.updateTheme(ThemeMode.dark);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).dark,
                        style: AppTextStyle.poppins16Regular
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSignOut() async {
    await _cubit.signOut();
    _onSignOutSuccess();
  }

  void _onSignOutSuccess() {
    Navigator.pushReplacementNamed(
      context,
      Routers.splash,
    );
  }
}
