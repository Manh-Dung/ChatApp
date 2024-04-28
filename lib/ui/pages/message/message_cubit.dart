import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/message_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepository repository;

  MessageCubit({required this.repository}) : super(MessageInitial());


}
