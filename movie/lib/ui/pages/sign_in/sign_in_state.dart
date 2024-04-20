part of 'sign_in_cubit.dart';

enum SignInStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
  USERNAME_PASSWORD_INVALID,
}

class SignInState extends Equatable {
  User? token;
  SignInStatus? signInStatus;

  SignInState({
    this.token,
    this.signInStatus = SignInStatus.INITIAL,
  });

  SignInState copyWith({
    User? token,
    SignInStatus? signInStatus,
  }) {
    return SignInState(
      token: token ?? this.token,
      signInStatus: signInStatus ?? this.signInStatus,
    );
  }

  @override
  List<Object> get props => [
    token ?? "",
    signInStatus ?? SignInStatus.INITIAL
  ];
}
