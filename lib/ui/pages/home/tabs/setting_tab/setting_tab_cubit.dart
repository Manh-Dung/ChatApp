import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhcine/models/base/base_cubit.dart';
import 'package:vinhcine/repositories/auth_repository.dart';

part 'setting_tab_state.dart';

class SettingTabCubit extends BaseCubit<SettingTabState> {
  SettingTabCubit({required this.repository})
      : super(WaitingForWarmingUp(), repository);
  AuthRepository repository;
  late SharedPreferences prefs;

  void signOut() async {
    try {
      emit(WaitingForSigningOut());
      repository.removeToken();
      await Future.delayed(Duration(seconds: 2));
      emit(SignedOutSuccessfully());
    } on Exception {
      ///todo do something here
    }
  }
}
