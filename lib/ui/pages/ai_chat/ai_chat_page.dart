import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../../network/firebase/instance.dart';
import 'ai_chat_cubit.dart';
import 'widgets/message_button.dart';

class AIChatPage extends StatelessWidget {
  AIChatPage({super.key});

  Gemini gemini = Gemini.instance;

  late AIChatCubit _cubit;

  ChatUser? currentUser, geminiUser;

  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    _cubit = context.read<AIChatCubit>();

    currentUser = ChatUser(
      id: Instances.auth.currentUser?.uid ?? '',
      firstName: Instances.auth.currentUser?.displayName ?? '',
    );

    geminiUser = ChatUser(
      id: "gemini",
      firstName: "Gemini",
      profileImage:
          "https://logowik.com/content/uploads/images/google-ai-gemini91216.logowik.com.webp",
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: MessageButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            geminiUser?.firstName ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return BlocBuilder<AIChatCubit, AIChatState>(
      buildWhen: (previous, current) => current is AIChatLoading,
      builder: (context, state) {
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersName: false,
            showTime: true,
          ),
          currentUser: currentUser!,
          onSend: (messages) async {
            await _sendMessage(messages);
          },
          messages: messages,
        );
      },
    );
  }

  Future<void> _sendMessage(ChatMessage message) async {
    messages = [message, ...messages];
    _cubit.sendMessage();
    try {
      final question = message.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue ${element.text}") ??
              "";
          lastMessage.text += response;
          messages = [lastMessage, ...messages];
          _cubit.sendMessage();
        } else {
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue ${element.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser!,
            text: response,
            createdAt: DateTime.now(),
          );
          messages = [message, ...messages];
          _cubit.sendMessage();
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
