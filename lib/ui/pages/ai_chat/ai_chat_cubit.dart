import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'ai_chat_state.dart';

class AIChatCubit extends Cubit<AIChatState> {
  AIChatCubit() : super(AIChatInitial());

  Gemini gemini = Gemini.instance;

  ChatUser geminiUser = ChatUser(
    id: "gemini",
    firstName: "Gemini",
    profileImage:
        "https://logowik.com/content/uploads/images/google-ai-gemini91216.logowik.com.webp",
  );

  Future<void> sendMessage(ChatMessage message) async {
    state.messages = [message, ...state.messages];
    emit(AIChatLoading(messages: state.messages));
    try {
      emit(AIChatSuccess(messages: state.messages));
      emit(AIChatWaiting(messages: state.messages));
      final question = message.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = state.messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = state.messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "${previousValue} ${element.text}") ??
              "";
          lastMessage.text += response;
          state.messages = [lastMessage, ...state.messages];
          emit(AIChatSuccess(messages: state.messages));
          emit(AIChatWaiting(messages: state.messages));
        } else {
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "${previousValue} ${element.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            text: response,
            createdAt: DateTime.now(),
          );
          state.messages = [message, ...state.messages];
          emit(AIChatSuccess(messages: state.messages));
        }
      });
    } catch (e) {
      emit(AIChatFailure(e.toString()));
    }
  }
}
