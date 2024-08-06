import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:vinhcine/models/base/base_cubit.dart';
import 'package:vinhcine/repositories/auth_repository.dart';

part 'setting_tab_state.dart';

class SettingTabCubit extends BaseCubit<SettingTabState> {
  SettingTabCubit({required this.repository})
      : super(WaitingForWarmingUp(), repository);
  AuthRepository repository;

  void signOut() async {
    try {
      emit(WaitingForSigningOut());
      repository.removeToken();
      await Future.delayed(Duration(seconds: 2));
      emit(SignedOutSuccessfully());
    } on Exception {
      emit(DidAnythingFail());
    }
  }
}
