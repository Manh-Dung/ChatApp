import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/configs/app_colors.dart';
import 'package:vinhcine/configs/di.dart';
import 'package:vinhcine/network/constants/constant_urls.dart';

import '../../../models/entities/chat.dart';
import '../../../models/entities/message.dart';
import '../../../models/entities/user_model.dart';
import '../../../network/firebase/instance.dart';
import '../../../src/gen/assets.gen.dart';
import 'message_cubit.dart';
import 'widgets/message_button.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageCubit _cubit = getIt<MessageCubit>();

  ChatUser? currentUser, otherUser;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, UserModel?>?;
    final UserModel? user = args?['user'];

    currentUser = ChatUser(
      id: Instances.auth.currentUser?.uid ?? '',
      firstName: Instances.auth.currentUser?.displayName ?? '',
    );

    if (user != null) {
      otherUser = ChatUser(
        id: user.uid ?? "",
        firstName: user.name,
        profileImage: user.imageUrl,
      );
    }

    return Scaffold(backgroundColor: Colors.white, body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        _buildHeader(context),
        Expanded(
          child: StreamBuilder(
            stream: _cubit.fetchMessages(
                currentUser?.id ?? "", otherUser?.id ?? ""),
            builder: (context, snapshot) {
              Chat? chat = snapshot.data?.data();
              List<ChatMessage> messages = [];

              if (chat != null && chat.messages != null) {
                messages = _generateMessageList(chat.messages!);
              }

              return DashChat(
                emptyWidget: messages.length == 0
                    ? Assets.images.imgEmptyMessage.image(
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      )
                    : null,
                messageOptions: MessageOptions(
                  showOtherUsersName: false,
                  showTime: true,
                ),
                inputOptions: InputOptions(
                  textCapitalization: TextCapitalization.sentences,
                  leading: <Widget>[
                    IconButton(
                      onPressed: () async {
                        var url = await _cubit.uploadImage(
                            currentUser?.id ?? "", otherUser?.id ?? "");

                        if (url != null) {
                          ChatMessage message = ChatMessage(
                            user: currentUser!,
                            medias: [
                              ChatMedia(
                                  url: url, fileName: "", type: MediaType.image)
                            ],
                            createdAt: DateTime.now(),
                          );
                          await _sendMessage(message);
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                currentUser: currentUser!,
                onSend: (messages) async {
                  await _sendMessage(messages);
                },
                messages: messages,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(children: [
      MessageButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () {
            Navigator.pop(context);
          }),
      CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(otherUser?.profileImage == ""
            ? ConstantUrls.placeholderImageUrl
            : otherUser?.profileImage ?? ConstantUrls.placeholderImageUrl),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            otherUser?.firstName ?? '',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Messenger',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.35),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      Spacer(),
      MessageButton(icon: Icons.phone_rounded, onPressed: () {}),
      MessageButton(icon: Icons.videocam_rounded, onPressed: () {}),
    ]);
  }

  List<ChatMessage> _generateMessageList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
            user: m.senderId == currentUser?.id ? currentUser! : otherUser!,
            medias: [
              ChatMedia(
                  url: m.content ?? '', fileName: '', type: MediaType.image)
            ],
            createdAt: m.sendAt!.toDate());
      } else {
        return ChatMessage(
            user: m.senderId == currentUser?.id ? currentUser! : otherUser!,
            text: m.content ?? '',
            createdAt: m.sendAt!.toDate());
      }
    }).toList();

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return chatMessages;
  }

  Future<void> _sendMessage(ChatMessage message) async {
    if (message.medias?.isNotEmpty ?? false) {
      if (message.medias?.first.type == MediaType.image) {
        Message m = Message(
          senderId: currentUser?.id,
          content: message.medias?.first.url,
          messageType: MessageType.Image,
          sendAt: Timestamp.fromDate(message.createdAt),
        );

        await _cubit.sendMessage(currentUser?.id ?? "", otherUser?.id ?? "", m);
      }
    } else {
      Message m = Message(
        senderId: currentUser?.id,
        content: message.text,
        messageType: MessageType.Text,
        sendAt: Timestamp.fromDate(message.createdAt),
      );

      await _cubit.sendMessage(currentUser?.id ?? "", otherUser?.id ?? "", m);
    }
  }
}
