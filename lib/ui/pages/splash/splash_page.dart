import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vinhcine/blocs/app_cubit.dart';
import 'package:vinhcine/configs/di.dart';
import 'package:vinhcine/router/routers.dart';
import 'package:vinhcine/ui/pages/sign_in/cubit/auth_cubit.dart';
import 'package:vinhcine/ui/widgets/loading_indicator_widget.dart';

import '../../../configs/app_colors.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  final AppCubit _appCubit = getIt<AppCubit>();
  final AuthCubit _authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _appCubit.fetchData();
    _authCubit.checkAuthState();

    initPermission();
  }

  void initPermission() async {
    await Permission.photos.request();
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _authCubit,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.success) {
            showHome();
          } else if (state.authStatus == AuthStatus.initial) {
            showSignIn();
          }
        },
        child: LoadingIndicatorWidget(color: Colors.white),
      ),
    );
  }

  ///Navigate
  void showSignIn() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routers.signIn,
      (route) => route.settings.name == Routers.signIn,
    );
  }

  void showHome() {
    Navigator.pushReplacementNamed(context, Routers.home);
  }
}
