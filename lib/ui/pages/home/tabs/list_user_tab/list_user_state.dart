part of 'list_user_cubit.dart';

abstract class ListUserState extends Equatable {
  const ListUserState();
}

final class ListUserInitial extends ListUserState {
  @override
  List<Object> get props => [];
}

final class ListUserLoading extends ListUserState {
  @override
  List<Object> get props => [];
}

final class ListUserSuccess extends ListUserState {
  final List<UserModel>? currentUser;

  ListUserSuccess({this.currentUser});

  @override
  List<Object> get props => [];
}

final class ListUserFailure extends ListUserState {
  final String message;

  ListUserFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ListUserLoaded extends ListUserState {
  final List<UserModel>? currentUser;
  final List<UserModel>? users;

  ListUserLoaded({this.users, this.currentUser});

  @override
  List<Object> get props => [];
}
