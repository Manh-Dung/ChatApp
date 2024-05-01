import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';

part 'ai_chat_state.dart';

class AIChatCubit extends Cubit<AIChatState> {
  AIChatCubit() : super(AIChatInitial());

  Future<void> sendMessage() async {
    emit(AIChatLoading());
    try {
      emit(AIChatSuccess());
    } catch (e) {
      emit(AIChatFailure(e.toString()));
    }
  }
}
