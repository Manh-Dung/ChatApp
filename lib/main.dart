import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vinhcine/blocs/app_cubit.dart';
import 'package:vinhcine/commons/app_environment.dart';
import 'package:vinhcine/commons/app_themes.dart';
import 'package:vinhcine/network/api_util.dart';
import 'package:vinhcine/repositories/auth_repository.dart';
import 'package:vinhcine/repositories/movie_repository.dart';
import 'package:vinhcine/ui/components/app_context.dart';

import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'router/pages.dart';
import 'router/routers.dart';

void main() async {
  await loadApp();
}

Future<void> loadApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (currentEnvironment == Environment.dev) {
    await GlobalConfiguration().loadFromAsset("configurations");
  } else {
    await GlobalConfiguration().loadFromAsset("configurations_prod");
  }

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
  ApiClient? _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.getApiClient();
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
            create: (context) => AuthRepositoryImpl(_apiClient)),
        RepositoryProvider<MovieRepository>(
            create: (context) => MovieRepositoryImpl(_apiClient)),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider<AppCubit>(create: (context) => AppCubit())],
        child: materialApp(),
      ),
    );
  }

  BlocBuilder<AppCubit, AppState> materialApp() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (prev, current) =>
          current is ChangedLanguageSuccessfully ||
          current is FetchedLanguageSuccessfully,
      builder: (context, state) {
        return MaterialApp(
          locale: state.currentLocale,
          navigatorKey: AppContext.navigatorKey,
          theme: AppThemes.theme,
          // onGenerateRoute: Application.router?.generator,
          initialRoute: Routes.root,
          routes: Pages.pages,
          // navigatorObservers: [
          //   NavigationObserver(context.bloc<NavigationCubit>()),
          // ],
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
