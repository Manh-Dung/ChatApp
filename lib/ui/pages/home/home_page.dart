import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/blocs/value_cubit.dart';
import 'package:vinhcine/repositories/user_repository.dart';
import 'package:vinhcine/ui/components/app_context.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/cubit/current_user/current_user_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/list_user_tab/list_user_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/notification_tab/notification_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/setting_tab/setting_tab_page.dart';
import 'package:vinhcine/ui/widgets/keep_alive_widget.dart';

import '../../../configs/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../repositories/auth_repository.dart';
import 'tabs/list_user_tab/cubit/list_user/list_user_cubit.dart';
import 'tabs/setting_tab/setting_tab_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0, keepPage: true);

  final tabs = [Tabs.HOME, Tabs.NOTIFICATION, Tabs.SETTING];

  final _tabCubit = ValueCubit<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      children: tabs.map((e) => e.page).toList(),
      onPageChanged: (index) {
        _tabCubit.update(index);
        _pageController.jumpToPage(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<ValueCubit<int>, int>(
      bloc: _tabCubit,
      builder: (context, state) {
        return Theme(
          data: ThemeData(),
          child: BottomNavigationBar(
            currentIndex: state,
            selectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 12),
            unselectedItemColor: Colors.black54,
            selectedItemColor: AppColors.primary,
            items: tabs.map((e) => e.tab).toList(),
            onTap: (index) {
              _tabCubit.update(index);
            },
          ),
        );
      },
    );
  }
}

enum Tabs {
  HOME,
  NOTIFICATION,
  SETTING,
}

extension TabsExtension on Tabs {
  Widget get page {
    switch (this) {
      case Tabs.HOME:
        return KeepAlivePage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CurrentUserCubit>(
                create: (context) {
                  final repository =
                      RepositoryProvider.of<UserRepository>(context);
                  return CurrentUserCubit(repository);
                },
              ),
              BlocProvider<ListUserCubit>(
                create: (context) {
                  final repository =
                      RepositoryProvider.of<UserRepository>(context);
                  return ListUserCubit(repository);
                },
              ),
            ],
            child: ListUserTabPage(),
          ),
        );
      case Tabs.NOTIFICATION:
        return NotificationTabPage();
      case Tabs.SETTING:
        // BlocProvider tạo 1 instance của SettingTabCubit cho SettingTabPage
        return BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<AuthRepository>(context);
            return SettingTabCubit(repository: repository);
          },
          child: SettingTabPage(),
        );
    }
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case Tabs.HOME:
        return BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.of(AppContext.navigatorKey.currentContext!).home);
      case Tabs.NOTIFICATION:
        return BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: S.of(AppContext.navigatorKey.currentContext!).notification);
      case Tabs.SETTING:
        return BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: S.of(AppContext.navigatorKey.currentContext!).setting);
    }
  }
}
