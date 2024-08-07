import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/ui/pages/message/message_cubit.dart';
import 'package:vinhcine/ui/pages/message/message_page.dart';
import 'package:vinhcine/ui/pages/sign_up/cubit/image_cubit.dart';

import '../configs/di.dart';
import '../ui/pages/ai_chat/ai_chat_cubit.dart';
import '../ui/pages/ai_chat/ai_chat_page.dart';
import '../ui/pages/forgot_password/forgot_password_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/sign_in/sign_in_page.dart';
import '../ui/pages/sign_up/sign_up_page.dart';
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
      Routers.splash: (context) => SplashPage(),
      Routers.signIn: (context) => SignInPage(),
      Routers.signUp: (context) => BlocProvider(
            create: (context) => ImageCubit(),
            child: SignUpPage(),
          ),
      Routers.forgotPassword: (context) => ForgotPasswordPage(),
      Routers.home: (context) => HomePage(),
      Routers.chat: _blocProvider(
        (context) => getIt<MessageCubit>(),
        MessagePage(),
      ),
      Routers.aiChat: _blocProvider(
        (context) => getIt<AIChatCubit>(),
        AIChatPage(),
      ),
    };
  }
}
