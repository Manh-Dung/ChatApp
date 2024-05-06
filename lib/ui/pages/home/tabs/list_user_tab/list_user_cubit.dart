import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/entities/user_model.dart';
import '../../../../../repositories/user_repository.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  UserRepository repository;
  StreamSubscription? _subscriptionListUser;
  StreamSubscription? _subscriptionUser;

  ListUserCubit({required this.repository}) : super(ListUserInitial()) {
    listenUsers();
    listenCurrentUser();
  }

  void listenCurrentUser() {
    _subscriptionUser = repository.getCurrentUser().listen((querySnapshot) {
      emit(ListUserSuccess(
          currentUser: querySnapshot.docs.map((e) => e.data()).toList()));
    }, onError: (e) {
      emit(ListUserFailure('Failed to get current user'));
    });
  }

  void listenUsers() {
    _subscriptionListUser = repository.getUsers().listen((querySnapshot) {
      emit(ListUserLoaded(
          users: querySnapshot.docs.map((e) => e.data()).toList()));
    }, onError: (e) {
      emit(ListUserFailure('Failed to listen list user'));
    });
  }

  Future<bool> checkChatExist(
      {required String? uid1, required String? uid2}) async {
    return await repository.checkChatExist(uid1: uid1, uid2: uid2);
  }

  Future<void> createChat(
      {required String? uid1, required String? uid2}) async {
    await repository.createChat(uid1: uid1, uid2: uid2);
  }

  @override
  Future<void> close() {
    _subscriptionListUser?.cancel();
    _subscriptionUser?.cancel();
    return super.close();
  }
}
