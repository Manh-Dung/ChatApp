import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../models/entities/chat.dart';
import '../../../models/entities/message.dart';
import '../../../repositories/message_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepository repository;

  MessageCubit({required this.repository}) : super(MessageInitial());

  Future<void> sendMessage(String uid1, String uid2, Message message) async {
    emit(MessageLoading());
    try {
      await repository.sendChat(uid1: uid1, uid2: uid2, message: message);
      emit(MessageSuccess());
    } catch (e) {
      emit(MessageFailure(e.toString()));
    }
  }

  Stream fetchMessages(String uid1, String uid2) {
    emit(MessageLoading());
    try {
      final messages = repository.getMessages(uid1: uid1, uid2: uid2);
      emit(MessageSuccess());
      return messages;
    } catch (e) {
      emit(MessageFailure(e.toString()));
      throw e;
    }
  }
}
