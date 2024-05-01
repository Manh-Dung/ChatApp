import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';

class MessageButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  const MessageButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: AppColors.primary,
        size: 28,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
