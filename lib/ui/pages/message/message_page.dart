import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/configs/app_colors.dart';

import '../../../models/entities/chat.dart';
import '../../../models/entities/message.dart';
import '../../../models/entities/user_model.dart';
import '../../../network/constants/constant_urls.dart';
import '../../../network/firebase/instance.dart';
import 'message_cubit.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessageCubit _cubit;
  ChatUser? currentUser, otherUser;

  UserModel? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cubit = context.read<MessageCubit>();
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
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Text(user?.name ?? ''),
        //   centerTitle: false,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: AppColors.primary),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(user?.imageUrl ?? ''),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '',
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
              IconButton(
                icon: Icon(
                  Icons.phone,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.videocam_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
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
                messageOptions: MessageOptions(
                  showOtherUsersAvatar: true,
                  showOtherUsersName: false,
                  showTime: true,
                  avatarBuilder: (chatUser, onPressAvatar, onLongPressAvatar) {
                    return Row(
                      children: [
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(user?.imageUrl == ""
                              ? ConstantUrls.placeholderImageUrl
                              : user?.imageUrl ??
                                  ConstantUrls.placeholderImageUrl),
                        ),
                        const SizedBox(width: 12),
                      ],
                    );
                  },
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
