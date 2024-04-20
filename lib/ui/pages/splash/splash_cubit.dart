import 'package:equatable/equatable.dart';
import 'package:vinhcine/repositories/auth_repository.dart';
import 'package:vinhcine/utils/logger.dart';

import '../../../models/base/base_cubit.dart';
import '../../../models/entities/index.dart';

part 'splash_state.dart';

enum SplashNavigator {
  OPEN_HOME,
  OPEN_SIGN_IN,
}

class SplashCubit extends BaseCubit<SplashState> {
  AuthRepository repository;

  SplashCubit({required this.repository})
      : super(WaitingForWarmingUp(), repository);

  void checkLogin() async {
    User? token = await repository.getToken();
    if (token == null) {
      logger.d('emit LOGGED_OUT');
      emit(NeedToSignOut());
    } else {
      logger.d('emit LOGGED_IN');
      emit(NeedToGoHome());
    }
  }

  void getUser() {}

  void getRemoteConfig() {}

  @override
  Future<void> close() {
    return super.close();
  }
}
