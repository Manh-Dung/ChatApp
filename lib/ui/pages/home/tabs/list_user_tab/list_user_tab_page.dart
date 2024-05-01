import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/list_user_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/widgets/user_widget.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../models/entities/index.dart';
import '../../../../../network/firebase/instance.dart';
import '../../../../../router/routers.dart';
import 'widgets/list_user_avatar_widget.dart';
import 'widgets/list_user_header.dart';
import 'widgets/list_user_search_bar.dart';

class ListUserTabPage extends StatelessWidget {
  const ListUserTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: AppColors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<ListUserCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 32),
        StreamBuilder<QuerySnapshot>(
          stream: cubit.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListUserHeader(isShimmer: true);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!.docs.first.data() as UserModel;
              return ListUserHeader(user: user);
            }
            return SizedBox();
          },
        ),
        ListUserSearchBar(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            constraints: BoxConstraints(maxHeight: 120),
            child: StreamBuilder<QuerySnapshot>(
              stream: cubit.fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildUserListAvatar();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return _buildUserListAvatar(users: snapshot.data!.docs);
                }
                return SizedBox();
              },
            )),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: cubit.fetchUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildUserList();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return _buildUserList(users: snapshot.data!.docs);
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUserList({List<DocumentSnapshot>? users}) {
    if (users == null) {
      return ListView.builder(
          itemBuilder: (_, __) => UserWidget(isShimmer: true),
          padding: EdgeInsets.zero,
          itemCount: 20);
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final user = users[index].data() as UserModel;
        return UserWidget(
          user: user,
          onTap: () => _userOnTap(context, user),
        );
      },
      padding: EdgeInsets.zero,
      itemCount: users.length ?? 0,
    );
  }

  void _userOnTap(BuildContext context, UserModel user) async {
    final cubit = context.read<ListUserCubit>();
    final isExist = await cubit.checkChatExist(
      uid1: Instances.auth.currentUser?.uid,
      uid2: user.uid,
    );

    if (!isExist) {
      await cubit.createChat(
        uid1: Instances.auth.currentUser!.uid,
        uid2: user.uid,
      );
    }

    Navigator.pushNamed(context, Routers.chat, arguments: {"user": user});
  }

  Widget _buildUserListAvatar({List<DocumentSnapshot>? users}) {
    if (users == null) {
      return ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(width: 24),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => ListUserAvatartWidget(isShimmer: true),
          padding: EdgeInsets.zero,
          itemCount: 20);
    }

    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(width: 24),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final user = users[index].data() as UserModel;
        return ListUserAvatartWidget(
          user: user,
          onPressed: () => _userOnTap(context, user),
        );
      },
      padding: EdgeInsets.zero,
      itemCount: users.length,
    );
  }
}
