part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  final User? token;
  final Locale? currentLocale;
  final ThemeMode? currentTheme;

  AppState({this.token, this.currentLocale, this.currentTheme});

  @override
  List<Object> get props => [
        token ?? FirebaseAuth.instance,
        currentLocale ?? Locale.fromSubtags(languageCode: 'vi'),
        currentTheme ?? ThemeMode.light,
      ];
}

// ignore: must_be_immutable
class WaitingForWarmingUp extends AppState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchedFullDataSuccessfully extends AppState {
  FetchedFullDataSuccessfully({
    super.token,
    super.currentLocale,
    super.currentTheme,
  });

  @override
  List<Object> get props => super.props;
}

// ignore: must_be_immutable
class WaitingForFetchingLanguage extends AppState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchedLanguageSuccessfully extends AppState {
  FetchedLanguageSuccessfully({
    super.currentLocale,
  });

  @override
  List<Object> get props => [
        currentLocale ?? Locale.fromSubtags(languageCode: 'vi'),
      ];
}

// ignore: must_be_immutable
class WaitingForChangingLanguage extends AppState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangedLanguageSuccessfully extends AppState {
  ChangedLanguageSuccessfully({super.currentLocale});

  @override
  List<Object> get props => [
        currentLocale ?? Locale.fromSubtags(languageCode: 'vi'),
      ];
}

// ignore: must_be_immutable
class WaitingForChangingTheme extends AppState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangedThemeSuccessfully extends AppState {
  ChangedThemeSuccessfully({super.currentTheme});

  @override
  List<Object> get props => [
        currentTheme ?? ThemeMode.light,
      ];
}

// ignore: must_be_immutable
class WaitingForFetchingTheme extends AppState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchedThemeSuccessfully extends AppState {
  FetchedThemeSuccessfully({
    super.currentTheme,
  });

  @override
  List<Object> get props => [
        currentTheme ?? ThemeMode.light,
      ];
}
