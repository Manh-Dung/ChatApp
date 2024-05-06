part of 'sign_in_cubit.dart';

enum SignInStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
  USERNAME_PASSWORD_INVALID
}

enum CheckBoxStatus { UNCHECKED, CHECKED }

class SignInState extends Equatable {
  String? token;
  SignInStatus? signInStatus;
  CheckBoxStatus? checkBoxStatus;

  SignInState({
    this.token,
    this.signInStatus = SignInStatus.INITIAL,
    this.checkBoxStatus = CheckBoxStatus.UNCHECKED,
  });

  SignInState copyWith({
    String? token,
    SignInStatus? signInStatus,
    CheckBoxStatus? checkBoxStatus,
  }) {
    return SignInState(
        token: token ?? this.token,
        signInStatus: signInStatus ?? this.signInStatus,
        checkBoxStatus: checkBoxStatus ?? this.checkBoxStatus);
  }

  @override
  List<Object> get props => [
        token ?? "",
        signInStatus ?? SignInStatus.INITIAL,
        checkBoxStatus ?? CheckBoxStatus.UNCHECKED
      ];
}
