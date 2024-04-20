import 'package:equatable/equatable.dart';
import 'package:vinhcine/models/base/base_cubit.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial(), null);
}
