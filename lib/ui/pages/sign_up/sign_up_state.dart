part of 'sign_up_cubit.dart';

enum SignUpStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
  EMAIL_PASSWORD_INVALID,
}

enum PickImageStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
}

class SignUpState extends Equatable {
  final SignUpStatus? signUpStatus;
  final PickImageStatus? pickImageStatus;

  const SignUpState({
    this.signUpStatus = SignUpStatus.INITIAL,
    this.pickImageStatus = PickImageStatus.INITIAL,
  });

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    PickImageStatus? pickImageStatus,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      pickImageStatus: pickImageStatus ?? this.pickImageStatus,
    );
  }

  @override
  List<Object?> get props => [
        signUpStatus ?? SignUpStatus.INITIAL,
        pickImageStatus ?? PickImageStatus.INITIAL
      ];
}
