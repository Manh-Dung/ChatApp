part of 'ai_chat_cubit.dart';

sealed class AIChatState extends Equatable {
  // final List<ChatMessage> messages;

  const AIChatState();

  @override
  List<Object> get props => [];
}

final class AIChatInitial extends AIChatState {
  @override
  List<Object> get props => [];
}

final class AIChatLoading extends AIChatState {
  @override
  List<Object> get props => [];
}

final class AIChatSuccess extends AIChatState {
  // final List<ChatMessage> messages;

  // AIChatSuccess(this.messages);
  @override
  List<Object> get props => [];
}

final class AIChatFailure extends AIChatState {
  final String message;

  AIChatFailure(this.message);

  @override
  List<Object> get props => [message];
}
