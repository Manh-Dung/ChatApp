import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';

class MovieDetailRating extends StatelessWidget {
  const MovieDetailRating({super.key, required this.rating});

  final num rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          color: AppColors.yellow,
          size: 12,
        ),
        Text(
          "${rating}/10 IMDb",
          style: TextStyle(fontSize: 15, color: AppColors.borderColor),
        ),
      ],
    );
  }
}
