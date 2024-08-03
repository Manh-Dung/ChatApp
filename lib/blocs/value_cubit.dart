import 'package:flutter_bloc/flutter_bloc.dart';

class ValueCubit<T> extends Cubit<T> {
  ValueCubit(T state) : super(state);

  void update(T state) => emit(state);
}
