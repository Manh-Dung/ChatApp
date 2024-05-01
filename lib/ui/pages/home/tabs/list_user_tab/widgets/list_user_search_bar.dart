import 'package:flutter/material.dart';

import '../../../../../../configs/app_colors.dart';
import '../../../../../../generated/l10n.dart';

class ListUserSearchBar extends StatelessWidget {
  const ListUserSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).search,
          hintStyle: TextStyle(color: AppColors.searchHintColor),
          prefixIcon: Icon(Icons.search, color: AppColors.searchHintColor),
          fillColor: Colors.black.withOpacity(0.05),
          filled: true,
          constraints: BoxConstraints(maxHeight: 36),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
