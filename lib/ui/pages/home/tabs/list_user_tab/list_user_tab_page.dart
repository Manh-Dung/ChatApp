import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/list_user_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/widgets/user_widget.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../models/entities/index.dart';
import '../../../../../network/firebase/instance.dart';
import '../../../../../router/routers.dart';
import 'widgets/list_user_avatar_widget.dart';
import 'widgets/list_user_gemini.dart';
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

    return BlocBuilder<ListUserCubit, ListUserState>(
      buildWhen: (previous, current) {
        return current is ListUserLoaded || current is ListUserInitial;
      },
      builder: (context, state) {
        if (state is ListUserInitial) {
          cubit.listenUsers();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 32),
              ListUserHeader(isShimmer: true),
              Shimmer.fromColors(
                  baseColor: AppColors.baseColor,
                  highlightColor: AppColors.highlightColor,
                  child: ListUserSearchBar()),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  constraints: BoxConstraints(maxHeight: 120),
                  child: _buildUserListHorizontal()),
              Expanded(child: _buildUserListVertical()),
            ],
          );
        }
        if (state is ListUserFailure) {
          return Center(child: Text(state.message));
        }
        if (state is ListUserLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 32),
              ListUserHeader(user: state.currentUser?.first),
              ListUserSearchBar(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  constraints: BoxConstraints(maxHeight: 120),
                  child: _buildUserListHorizontal(users: state.users)),
              Expanded(child: _buildUserListVertical(users: state.users)),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void _userOnTap(BuildContext context, UserModel? user) async {
    final cubit = context.read<ListUserCubit>();
    final isExist = await cubit.checkChatExist(
      uid1: Instances.auth.currentUser?.uid,
      uid2: user?.uid,
    );

    if (!isExist) {
      await cubit.createChat(
        uid1: Instances.auth.currentUser!.uid,
        uid2: user?.uid,
      );
    }

    Navigator.pushNamed(context, Routers.chat, arguments: {"user": user});
  }

  Widget _buildUserListVertical({List<UserModel>? users}) {
    if (users == null) {
      return ListView.builder(
          itemBuilder: (_, __) => UserWidget(isShimmer: true),
          padding: EdgeInsets.zero,
          itemCount: 20);
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListUserGemini();
        } else {
          final user = users[index - 1];
          return UserWidget(
            user: user,
            onTap: () => _userOnTap(context, user),
          );
        }
      },
      padding: EdgeInsets.zero,
      itemCount: users.length,
      shrinkWrap: true,
    );
  }

  Widget _buildUserListHorizontal({List<UserModel>? users}) {
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
        final user = users[index];
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
