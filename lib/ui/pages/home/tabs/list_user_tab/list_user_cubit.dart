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
}
