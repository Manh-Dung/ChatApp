import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../../../models/entities/user_model.dart';
import '../../../network/firebase/instance.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final _cubit;
  late final ChatUser? currentUser, otherUser;
  late final UserModel? user;

  @override
  void didChangeDependencies() {
    // _cubit = context.read<MessageCubit>();

    super.didChangeDependencies();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user?.name ?? ''),
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser!,
      onSend: (messages) {},
      messages: [],
    );
  }
}
