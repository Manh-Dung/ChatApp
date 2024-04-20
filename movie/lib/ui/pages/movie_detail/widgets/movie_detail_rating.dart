import 'package:flutter/material.dart';

import '../../../../configs/app_color.dart';

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
          color: AppColor.yellow,
          size: 12,
        ),
        Text(
          "${rating}/10 IMDb",
          style: TextStyle(fontSize: 15, color: AppColor.borderColor),
        ),
      ],
    );
  }
}
