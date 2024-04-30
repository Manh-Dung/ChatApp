import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/configs/app_colors.dart';
import 'package:vinhcine/network/firebase/instance.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/list_user_cubit.dart';
import 'package:vinhcine/ui/widgets/customized_scaffold_widget.dart';

import '../../../../../models/entities/index.dart';
import '../../../../../router/routers.dart';
import '../../../../widgets/app_bar_widget.dart';
import 'widgets/user_widget.dart';

class ListUserTabPage extends StatelessWidget {
  const ListUserTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        body: _buildBody(context), appBar: AppBarWidget(title: "Messages"));
  }

  Widget _buildBody(BuildContext context) {
    final ListUserCubit cubit = context.read<ListUserCubit>();

    return SafeArea(
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<QuerySnapshot<UserModel>>(
          stream: cubit.fetchUsers(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final user = snapshot.data!.docs[index].data();
                  return UserWidget(
                    user: user,
                    onTap: () async {
                      var isExist = await cubit.checkChatExist(
                        uid1: Instances.auth.currentUser?.uid,
                        uid2: user.uid,
                      );

                      if (!isExist) {
                        await cubit.createChat(
                          uid1: Instances.auth.currentUser!.uid,
                          uid2: user.uid,
                        );
                        Navigator.pushNamed(context, Routers.chat,
                            arguments: {"user": user});
                      } else {
                        Navigator.pushNamed(context, Routers.chat,
                            arguments: {"user": user});
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8),
                itemCount: snapshot.data!.docs.length,
              );
            }
            return const Center(child: Text('Failed to fetch users'));
          },
        ),
      ),
    );
  }
}
