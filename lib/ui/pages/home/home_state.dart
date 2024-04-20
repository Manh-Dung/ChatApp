part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int? currentTabIndex;

  HomeState({
    this.currentTabIndex = 0,
  });

  HomeState copyWith({
    int? currentTabIndex,
  }) {
    return HomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        this.currentTabIndex ?? 0,
  ];
}
