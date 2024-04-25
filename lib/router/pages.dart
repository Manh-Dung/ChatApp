import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/repositories/movie_repository.dart';
import 'package:vinhcine/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:vinhcine/ui/pages/movie_detail/movie_detail_page.dart';

import '../repositories/auth_repository.dart';
import '../ui/pages/forgot_password/forgot_password_page.dart';
import '../ui/pages/home/home_cubit.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/sign_in/sign_in_cubit.dart';
import '../ui/pages/sign_in/sign_in_page.dart';
import '../ui/pages/sign_up/sign_up_page.dart';
import '../ui/pages/splash/splash_cubit.dart';
import '../ui/pages/splash/splash_page.dart';
import 'routers.dart';

class Pages {
  static WidgetBuilder _blocProvider<T extends Cubit<Object>>(
      T Function(BuildContext) create, Widget child) {
    return (context) =>
        BlocProvider(create: (context) => create(context), child: child);
  }

  static Map<String, WidgetBuilder> get pages {
    return {
      Routers.root: _blocProvider(
          (context) => SplashCubit(
              repository: RepositoryProvider.of<AuthRepository>(context)),
          SplashPage()),
      Routers.signIn: _blocProvider(
          (context) => SignInCubit(
              repository: RepositoryProvider.of<AuthRepository>(context)),
          SignInPage()),
      Routers.signUp: (context) => SignUpPage(),
      Routers.forgotPassword: (context) => ForgotPasswordPage(),
      Routers.home: _blocProvider((context) => HomeCubit(), HomePage()),
      Routers.movieDetail: _blocProvider(
          (context) => MovieDetailCubit(
              repository: RepositoryProvider.of<MovieRepository>(context)),
          MovieDetailPage()),
    };
  }
}
