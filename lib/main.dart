import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:vinhcine/blocs/app_cubit.dart';
import 'package:vinhcine/commons/app_environment.dart';
import 'package:vinhcine/commons/app_themes.dart';
import 'package:vinhcine/configs/di.dart';
import 'package:vinhcine/firebase_options.dart';
import 'package:vinhcine/network/constants/constant_urls.dart';
import 'package:vinhcine/ui/components/app_context.dart';
import 'package:vinhcine/ui/pages/sign_in/cubit/auth_cubit.dart';

import 'generated/l10n.dart';
import 'network/firebase/firebase_api.dart';
import 'repositories/repositories.dart';
import 'router/pages.dart';
import 'router/routers.dart';

void main() async {
  await loadApp();
}

Future<void> loadApp() async {
  TorchController().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initialize();
  if (currentEnvironment == Environment.dev) {
    await GlobalConfiguration().loadFromAsset("configurations");
  } else {
    await GlobalConfiguration().loadFromAsset("configurations_prod");
  }

  await Gemini.init(
    apiKey: ConstantUrls.apiKey,
  );

  configureDependencies();

  /// AWAIT SERVICES INITIALIZATION.
  await initServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

/// Is a smart move to make your Services initialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesn't have to rebuild, and takes the values directly.
Future initServices() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Hive.initFlutter();
}

class MyApp extends StatefulWidget {
  MyApp() {
    // final router = new FluroRouter();
    // Routes.configureRoutes(router);
    // Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => getIt<AuthRepository>()),
        RepositoryProvider<UserRepository>(
            create: (context) => getIt<UserRepository>()),
        RepositoryProvider<MessageRepository>(
            create: (context) => MessageRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => getIt<AppCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<AuthCubit>(),
          ),
        ],
        child: materialApp(),
      ),
    );
  }

  BlocBuilder<AppCubit, AppState> materialApp() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          themeMode: ThemeMode.system,
          locale: state.currentLocale,
          navigatorKey: AppContext.navigatorKey,
          theme: AppThemes.theme,
          // onGenerateRoute: Application.router?.generator,
          initialRoute: Routers.splash,
          routes: Pages.pages,
          // navigatorObservers: [
          //   NavigationObserver(context.bloc<NavigationCubit>()),
          // ],
          builder: EasyLoading.init(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}

showLoading() {
  EasyLoading.show();
}

hideLoading() {
  EasyLoading.dismiss();
}
