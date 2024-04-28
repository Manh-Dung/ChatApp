part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();
}

final class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}
