import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/list_user_cubit.dart';
import 'package:vinhcine/ui/widgets/customized_scaffold_widget.dart';

import '../../../../widgets/app_bar_widget.dart';
import 'widgets/user_widget.dart';

class ListUserTabPage extends StatelessWidget {
  const ListUserTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        body: _buildBody(context),
        appBar: AppBarWidget(
            title: "Message"
                "s"));
  }

  Widget _buildBody(BuildContext context) {
    final ListUserCubit cubit = context.read<ListUserCubit>();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
            stream: cubit.fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  height: 1000,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return UserWidget(
                          user: snapshot.data.docs[index].data(),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8),
                      itemCount: snapshot.data.docs.length),
                );
              }
              return const Center(child: Text('Failed to fetch users'));
            }),
      ),
    );
  }
}
