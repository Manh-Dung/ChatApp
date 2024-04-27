import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/ui/components/app_context.dart';
import 'package:vinhcine/ui/pages/home/home_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/movie_tab/movie_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/notification_tab/notification_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/setting_tab/setting_tab_page.dart';
import 'package:vinhcine/ui/widgets/keep_alive_widget.dart';
import 'package:vinhcine/utils/logger.dart';

import '../../../configs/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../repositories/auth_repository.dart';
import 'tabs/setting_tab/setting_tab_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    super.initState();
    _cubit.stream.listen((state) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(),
    );
  }
}
