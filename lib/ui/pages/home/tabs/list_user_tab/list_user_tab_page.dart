import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vinhcine/blocs/value_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/widgets/user_widget.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../configs/di.dart';
import '../../../../../models/entities/index.dart';
import '../../../../../network/firebase/instance.dart';
import '../../../../../router/routers.dart';
import 'cubit/current_user/current_user_cubit.dart';
import 'cubit/list_user/list_user_cubit.dart';
import 'widgets/list_user_avatar_widget.dart';
import 'widgets/list_user_gemini.dart';
import 'widgets/list_user_header.dart';
import 'widgets/list_user_search_bar.dart';

class ListUserTabPage extends StatelessWidget {
  ListUserTabPage({Key? key}) : super(key: key);
  final _shimmerCubit = ValueCubit<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: AppColors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    final cubit = getIt<ListUserCubit>();
    final currentUserCubit = getIt<CurrentUserCubit>();

    _shimmerCubit.stream.listen((loading) {
      _shimmerCubit.update(!(cubit.state.status == FetchUserStatus.success) ||
          !(currentUserCubit.state.status == FetchUserStatus.success));
    });

    return BlocBuilder<ValueCubit<bool>, bool>(
      bloc: _shimmerCubit,
      builder: (context, loadingState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 32),
            BlocBuilder<CurrentUserCubit, CurrentUserState>(
              bloc: currentUserCubit,
              builder: (context, state) {
                return ListUserHeader(
                  isShimmer: loadingState,
                  user: state.user,
                );
              },
            ),
            loadingState
                ? Shimmer.fromColors(
                    baseColor: AppColors.baseColor,
                    highlightColor: AppColors.highlightColor,
                    child: ListUserSearchBar())
                : ListUserSearchBar(),
            BlocBuilder<ListUserCubit, ListUserState>(
              bloc: cubit,
              builder: (context, state) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  constraints: BoxConstraints(maxHeight: 120),
                  child: _buildUserListHorizontal(
                    users: state.status == FetchUserStatus.success
                        ? state.users
                        : null,
                    isShimmer: loadingState,
                  ),
                );
              },
            ),
            BlocBuilder<ListUserCubit, ListUserState>(
              builder: (context, state) {
                return Expanded(
                  child: _buildUserListVertical(
                    isShimmer: loadingState,
                    users: state.status == FetchUserStatus.success
                        ? state.users
                        : null,
                  ),
                );
              },
            ),
          ],
        );
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

  Widget _buildUserListVertical(
      {List<UserModel>? users, bool isShimmer = false}) {
    if (isShimmer) {
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
          final user = users?[index - 1];
          return UserWidget(
            user: user,
            onTap: () => _userOnTap(context, user),
          );
        }
      },
      padding: EdgeInsets.zero,
      itemCount: users?.length ?? 0,
      shrinkWrap: true,
    );
  }

  Widget _buildUserListHorizontal(
      {List<UserModel>? users, bool isShimmer = false}) {
    if (isShimmer) {
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
        final user = users?[index];
        return ListUserAvatartWidget(
          user: user,
          onPressed: () => _userOnTap(context, user),
        );
      },
      padding: EdgeInsets.zero,
      itemCount: users?.length ?? 0,
    );
  }
}
