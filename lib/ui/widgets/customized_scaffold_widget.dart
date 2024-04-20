import 'package:flutter/material.dart';
import 'package:vinhcine/generated/l10n.dart';
import 'package:vinhcine/ui/widgets/app_bar_widget.dart';
import 'package:vinhcine/ui/widgets/status_bar_widget.dart';

class CustomizedScaffold extends StatelessWidget {
  CustomizedScaffold(
      {required this.body, required this.appBar, this.floatingActionButton});

  final Widget body;
  final Widget appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            StatusBarWidget(),
            appBar ??
                AppBarWidget(title: S.of(context).movies, onBackPressed: () {}),
            Expanded(
              child: body,
            ),
          ],
        ),
        floatingActionButton: floatingActionButton);
  }
}
