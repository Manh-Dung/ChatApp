import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinhcine/repositories/auth_repository.dart';
import 'package:vinhcine/utils/logger.dart';

import '../../../database/preferences.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  AuthRepository repository;

  SignInCubit({required this.repository}) : super(SignInState());

  void signIn(String username, String password) async {
    emit(state.copyWith(signInStatus: SignInStatus.LOADING));
    try {
      final result = await repository.signIn(username, password);
      await repository.saveToken(result.uid);
      if (state.checkBoxStatus == CheckBoxStatus.UNCHECKED) {
        repository.removePassword();
      }
      if (state.checkBoxStatus == CheckBoxStatus.CHECKED) {
        repository.savePassword(username, password);
      }
      emit(state.copyWith(signInStatus: SignInStatus.SUCCESS));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInStatus: SignInStatus.FAILURE));
    }
  }

  void initCheckBoxStatus() async {
    final preferences = await Preferences.getInstance();
  }

  void checkBox(bool? value) {
    if (value ?? false)
      emit(state.copyWith(checkBoxStatus: CheckBoxStatus.CHECKED));
    else
      emit(state.copyWith(checkBoxStatus: CheckBoxStatus.UNCHECKED));
  }
}
