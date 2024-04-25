import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';

class MovieDetailName extends StatelessWidget {
  const MovieDetailName({super.key, required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.bookmark_add_outlined,
              size: 24,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
