import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vinhcine/network/firebase/instance.dart';

import '../../../../blocs/value_cubit.dart';
import '../../../../repositories/repositories.dart';
import '../../../../repositories/storage_repository.dart';
import '../../../../utils/logger.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthCubit extends ValueCubit<AuthState> {
  AuthCubit({required this.repository}) : super(AuthState());

  final AuthRepository repository;
  final StorageRepository storageRepository = StorageRepositoryImpl();

  Future<void> checkAuthState() async {
    Instances.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(state.copyWith(authStatus: AuthStatus.initial));
      } else {
        emit(state.copyWith(authStatus: AuthStatus.success));
      }
    });
  }

  void signIn(String username, String password) async {
    update(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final result = await repository.signIn(username, password);
      await repository.saveToken(result.uid);
      update(state.copyWith(authStatus: AuthStatus.success));
    } catch (error) {
      logger.e(error);
      update(
        state.copyWith(
          authStatus: AuthStatus.failure,
          errorMess: error.toString(),
        ),
      );
    }
  }

  Future<void> signUp({
    required File? file,
    required String fullName,
    required String email,
    required String password,
  }) async {
    update(state.copyWith(authStatus: AuthStatus.loading));
    try {
      var res = await repository.signUp(file, fullName, email, password);
      await repository.saveToken(res.uid);
      update(state.copyWith(authStatus: AuthStatus.success));
    } catch (e) {
      logger.e(e);
      update(
        state.copyWith(
          authStatus: AuthStatus.failure,
          errorMess: e.toString(),
        ),
      );
    }
  }
}
