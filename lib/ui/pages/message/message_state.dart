part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

}

final class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageSuccess extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageFailure extends MessageState {
  final String message;

  MessageFailure(this.message);

  @override
  List<Object> get props => [message];
}