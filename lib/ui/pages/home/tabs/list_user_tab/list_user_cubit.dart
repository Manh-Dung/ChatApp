import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/entities/user_model.dart';
import '../../../../../repositories/user_repository.dart';

part 'list_user_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  UserRepository repository;

  ListUserCubit({required this.repository}) : super(ListUserInitial());

  Stream<QuerySnapshot<UserModel>> fetchUsers() {
    emit(ListUserLoading());
    try {
      Stream<QuerySnapshot<UserModel>> users = repository.getUsers();
      emit(ListUserSuccess());
      return users;
    } catch (e) {
      emit(ListUserFailure('Failed to fetch users'));
      throw e;
    }
  }

  Stream<QuerySnapshot<UserModel>> getCurrentUser() {
    return repository.getCurrentUser();
  }

  Future<bool> checkChatExist(
      {required String? uid1, required String? uid2}) async {
    return await repository.checkChatExist(uid1: uid1, uid2: uid2);
  }

  Future<void> createChat(
      {required String? uid1, required String? uid2}) async {
    await repository.createChat(uid1: uid1, uid2: uid2);
  }
}
