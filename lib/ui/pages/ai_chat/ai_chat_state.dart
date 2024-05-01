part of 'ai_chat_cubit.dart';

sealed class AIChatState extends Equatable {
  List<ChatMessage> messages;

  AIChatState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}

final class AIChatInitial extends AIChatState {
  AIChatInitial({super.messages});

  @override
  List<Object> get props => [];
}

final class AIChatLoading extends AIChatState {
  AIChatLoading({super.messages});

  @override
  List<Object> get props => [];
}

final class AIChatSuccess extends AIChatState {
  AIChatSuccess({super.messages});

  @override
  List<Object> get props => [];
}

final class AIChatWaiting extends AIChatState {
  AIChatWaiting({super.messages});

  @override
  List<Object> get props => [];
}

final class AIChatFailure extends AIChatState {
  final String message;

  AIChatFailure(this.message, {super.messages});

  @override
  List<Object> get props => [...super.props, message];
}
