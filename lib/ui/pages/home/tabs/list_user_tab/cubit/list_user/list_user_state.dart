part of 'list_user_cubit.dart';

@freezed
class ListUserState with _$ListUserState {
  const factory ListUserState({
    @Default(FetchUserStatus.initial) FetchUserStatus status,
    List<UserModel>? users,
    String? errorMess,
}) = _ListUserState;
}
