part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

// ignore: must_be_immutable
class WaitingForWarmingUp extends SplashState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class NeedToSignOut extends SplashState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class NeedToGoHome extends SplashState {
  @override
  List<Object> get props => [];
}
