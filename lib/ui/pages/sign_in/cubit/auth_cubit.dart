import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:vinhcine/network/firebase/instance.dart';

import '../../../../blocs/value_cubit.dart';
import '../../../../repositories/repositories.dart';
import '../../../../utils/logger.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

enum AuthStatus { initial, loading, success, failure }

@singleton
class AuthCubit extends ValueCubit<AuthState> {
  AuthCubit({
    required this.repository,
    required this.storageRepository,
  }) : super(AuthState());

  final AuthRepository repository;
  final StorageRepository storageRepository;

  Future<void> checkAuthState() async {
    Instances.auth.authStateChanges().listen((User? user) {
      emit(state.copyWith(authStatus: AuthStatus.loading));
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
      await repository.signIn(username, password);
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

  Future<void> signOut() async {
    update(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await repository.signOut();
      update(state.copyWith(authStatus: AuthStatus.initial));
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
