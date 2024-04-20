import 'package:equatable/equatable.dart';
import 'package:vinhcine/models/base/base_cubit.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState(), null);

  void changeTab(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }
}
