part of 'setting_tab_cubit.dart';

abstract class SettingTabState extends Equatable {
  Locale? currentLocale;

  SettingTabState({
    this.currentLocale
  });

  @override
  List<Object> get props => [
    currentLocale ?? Locale.fromSubtags(languageCode: 'vi'),
  ];
}

// ignore: must_be_immutable
class WaitingForWarmingUp extends SettingTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WaitingForSigningOut extends SettingTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DidAnythingFail extends SettingTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignedOutSuccessfully extends SettingTabState {
  @override
  List<Object> get props => [];
}
