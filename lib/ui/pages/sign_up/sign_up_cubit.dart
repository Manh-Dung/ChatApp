import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth_repository.dart';
import '../../../utils/logger.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  AuthRepository repository;

  SignUpCubit({required this.repository}) : super(SignUpState());

  void signUp(String fullName,String email, String password) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.LOADING));
    try {
      var res = await repository.signUp(fullName, email, password);
      await repository.saveToken(res.uid);

      emit(state.copyWith(signUpStatus: SignUpStatus.SUCCESS));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signUpStatus: SignUpStatus.FAILURE));
    }
  }
}
