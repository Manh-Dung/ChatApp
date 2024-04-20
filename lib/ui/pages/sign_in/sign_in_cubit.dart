import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinhcine/models/entities/index.dart';
import 'package:vinhcine/models/enums/load_status.dart';
import 'package:vinhcine/repositories/auth_repository.dart';
import 'package:vinhcine/utils/logger.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  AuthRepository repository;

  SignInCubit({required this.repository}) : super(SignInState());

  void signIn(String username, String password) async {
    emit(state.copyWith(signInStatus: SignInStatus.LOADING));
    try {
      final result = await repository.signIn(username, password);
      await repository.saveToken(result);
      emit(state.copyWith(signInStatus: SignInStatus.SUCCESS));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInStatus: SignInStatus.FAILURE));
    }
  }
}
