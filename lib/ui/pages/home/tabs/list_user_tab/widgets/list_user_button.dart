import 'package:flutter/material.dart';

import '../../../../../../configs/app_colors.dart';

class ListUserButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const ListUserButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(color: AppColors.baseColor, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.black)),
    );
  }
}
