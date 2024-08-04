part of 'current_user_cubit.dart';

@freezed
class CurrentUserState with _$CurrentUserState {
  const factory CurrentUserState({
    @Default(FetchUserStatus.initial) FetchUserStatus status,
    UserModel? user,
    String? errorMess,
  }) = _CurrentUserState;
}
