part of 'sign_up_cubit.dart';

enum SignUpStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
  EMAIL_PASSWORD_INVALID,
}

class SignUpState extends Equatable {
  final SignUpStatus? signUpStatus;

  const SignUpState({
    this.signUpStatus = SignUpStatus.INITIAL,
  });

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }

  @override
  List<Object?> get props => [signUpStatus ?? SignUpStatus.INITIAL];
}
