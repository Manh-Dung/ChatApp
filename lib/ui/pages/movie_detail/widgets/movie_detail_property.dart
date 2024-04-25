import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';

class MovieDetailProperty extends StatelessWidget {
  final String tag;
  final String value;

  const MovieDetailProperty(
      {super.key, required this.tag, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(color: AppColors.borderColor, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(color: AppColors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
