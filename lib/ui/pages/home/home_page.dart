import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/commons/app_colors.dart';
import 'package:vinhcine/ui/components/app_context.dart';
import 'package:vinhcine/ui/pages/home/home_cubit.dart';
import 'package:vinhcine/ui/pages/home/tabs/movie_tab/movie_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/notification_tab/notification_tab_page.dart';
import 'package:vinhcine/ui/pages/home/tabs/setting_tab/setting_tab_page.dart';
import 'package:vinhcine/ui/widgets/keep_alive_widget.dart';
import 'package:vinhcine/utils/logger.dart';

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
  final _pageController = PageController(initialPage: 0, keepPage: true);

  final tabs = [Tabs.HOME, Tabs.NOTIFICATION, Tabs.SETTING];

  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    super.initState();
    _cubit.stream.listen((state) {
      logger.d('Change tab1 ${state.currentTabIndex}');
      _pageController.jumpToPage(state.currentTabIndex ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      children: tabs.map((e) => e.page).toList(),
      onPageChanged: (index) {
        _cubit.changeTab(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, current) {
        return prev.currentTabIndex != current.currentTabIndex;
      },
      builder: (context, state) {
        return Theme(
          data: ThemeData(),
          child: BottomNavigationBar(
            currentIndex: state.currentTabIndex ?? 0,
            unselectedItemColor: Colors.black54,
            selectedItemColor: AppColors.main,
            items: tabs.map((e) => e.tab).toList(),
            onTap: (index) {
              _cubit.changeTab(index);
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
        return KeepAlivePage(child: MovieTabPage());
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
