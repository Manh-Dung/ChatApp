import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../blocs/value_cubit.dart';
import '../../../../../../../models/entities/index.dart';
import '../../../../../../../repositories/repositories.dart';
import '../current_user/current_user_cubit.dart';

part 'list_user_state.dart';

part 'list_user_cubit.freezed.dart';

class ListUserCubit extends ValueCubit<ListUserState> {
  ListUserCubit(this.repository) : super(const ListUserState()) {
    listenUsers();
  }

  final UserRepository repository;

  StreamSubscription? _subscriptionUser;

  void listenUsers() {
    update(ListUserState(status: FetchUserStatus.loading));

    _subscriptionUser = repository.getUsers().listen((querySnapshot) {
      update(ListUserState(
          status: FetchUserStatus.success,
          users: querySnapshot.docs.map((e) => e.data()).toList()));
    }, onError: (e) {
      update(ListUserState(
          status: FetchUserStatus.error,
          errorMess: 'Failed to listen list user'));
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
    _subscriptionUser?.cancel();
    return super.close();
  }
}
