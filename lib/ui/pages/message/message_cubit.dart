import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../models/entities/message.dart';
import '../../../repositories/message_repository.dart';
import '../../../repositories/storage_repository.dart';

part 'message_state.dart';

@injectable
class MessageCubit extends Cubit<MessageState> {
  final MessageRepository repository;
  final StorageRepository storageRepository;

  MessageCubit({
    required this.repository,
    required this.storageRepository,
  }) : super(MessageInitial());

  Future<void> sendMessage(String uid1, String uid2, Message message) async {
    emit(MessageLoading());
    try {
      await repository.sendMessage(uid1: uid1, uid2: uid2, message: message);
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

  Future<String?> uploadImage(String uid1, String uid2) async {
    emit(MessageLoading());
    try {
      final file = await storageRepository.pickImage();
      if (file != null) {
        var path = await storageRepository.uploadImageToChat(
            file: file, chatId: "$uid1$uid2");
        return path;
      }
    } catch (e) {
      emit(MessageFailure(e.toString()));
      return null;
    }
  }
}
