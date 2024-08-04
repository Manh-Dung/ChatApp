import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vinhcine/blocs/value_cubit.dart';
import 'package:vinhcine/repositories/repositories.dart';

import '../../../../../../../models/entities/user_model.dart';

part 'current_user_state.dart';

part 'current_user_cubit.freezed.dart';

enum FetchUserStatus { initial, loading, success, error }

class CurrentUserCubit extends ValueCubit<CurrentUserState> {
  CurrentUserCubit(this.repository) : super(const CurrentUserState()) {
    listenCurrentUser();
  }

  final UserRepository repository;

  StreamSubscription? _subscriptionUser;

  void listenCurrentUser() {
    update(CurrentUserState(status: FetchUserStatus.loading));
    _subscriptionUser = repository.getCurrentUser().listen((querySnapshot) {
      update(CurrentUserState(
          status: FetchUserStatus.success,
          user: querySnapshot.docs.map((e) => e.data()).first));
    }, onError: (e) {
      update(
        CurrentUserState(
            status: FetchUserStatus.error,
            errorMess: 'Failed to get current user'),
      );
    });
  }

  @override
  Future<void> close() {
    _subscriptionUser?.cancel();
    return super.close();
  }
}
