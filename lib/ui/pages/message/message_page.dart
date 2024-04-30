import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/entities/chat.dart';
import '../../../models/entities/message.dart';
import '../../../models/entities/user_model.dart';
import '../../../network/firebase/instance.dart';
import 'message_cubit.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // late MessageCubit _cubit;
  ChatUser? currentUser, otherUser;

  UserModel? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, UserModel?>;
    user = args['user'];

    currentUser = ChatUser(
      id: Instances.auth.currentUser?.uid ?? '',
      firstName: Instances.auth.currentUser?.displayName ?? '',
    );

    if (user != null) {
      otherUser = ChatUser(
        id: user?.uid ?? "",
        firstName: user?.name,
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(user?.name ?? ''),
          centerTitle: false,
          leading: InkWell(
            child: Icon(Icons.arrow_back, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    final MessageCubit _cubit = context.read<MessageCubit>();

    return StreamBuilder(
        stream:
            _cubit.fetchMessages(currentUser?.id ?? "", otherUser?.id ?? ""),
        builder: (context, snapshot) {
          Chat? chat = snapshot.data?.data();
          List<ChatMessage> messages = [];

          if (chat != null && chat.messages != null) {
            messages = _generateMessage(chat.messages!);
          }

          return DashChat(
            messageOptions: const MessageOptions(
              showOtherUsersAvatar: true,
              showTime: true,
            ),
            inputOptions: InputOptions(
              alwaysShowSend: true,
            ),
            currentUser: currentUser!,
            onSend: (messages) async {
              Message message = Message(
                senderId: currentUser?.id,
                content: messages.text,
                sendAt: Timestamp.fromDate(messages.createdAt),
              );
              await _cubit.sendMessage(
                  currentUser?.id ?? "", otherUser?.id ?? "", message);
            },
            messages: messages,
          );
        });
  }

  List<ChatMessage> _generateMessage(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      return ChatMessage(
          user: m.senderId == currentUser?.id ? currentUser! : otherUser!,
          text: m.content ?? '',
          createdAt: m.sendAt!.toDate());
    }).toList();

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return chatMessages;
  }
}
