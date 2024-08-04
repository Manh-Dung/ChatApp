import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/firebase/instance.dart';
import 'ai_chat_cubit.dart';
import 'widgets/message_button.dart';

class AIChatPage extends StatefulWidget {
  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  late AIChatCubit _cubit;

  ChatUser? currentUser = ChatUser(
    id: Instances.auth.currentUser?.uid ?? '',
    firstName: Instances.auth.currentUser?.displayName ?? '',
  );

  @override
  Widget build(BuildContext context) {
    _cubit = context.read<AIChatCubit>();

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
            'Gemini',
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
      buildWhen: (previous, current) => current is AIChatSuccess,
      builder: (context, state) {
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersName: false,
            showTime: true,
          ),
          inputOptions: InputOptions(
            textCapitalization: TextCapitalization.sentences,
          ),
          currentUser: currentUser!,
          onSend: (messages) async {
            await _cubit.sendMessage(messages);
          },
          messages: state.messages,
        );
      },
    );
  }
}
