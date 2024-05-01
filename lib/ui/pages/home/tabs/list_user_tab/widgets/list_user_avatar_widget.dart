import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../configs/app_colors.dart';
import '../../../../../../models/entities/index.dart';
import '../../../../../../network/constants/constant_urls.dart';

class ListUserAvatartWidget extends StatelessWidget {
  final UserModel? user;
  final Function()? onPressed;
  final bool? isShimmer;

  const ListUserAvatartWidget(
      {super.key, this.user, this.onPressed, this.isShimmer});

  @override
  Widget build(BuildContext context) {
    if (isShimmer ?? false) {
      return Shimmer.fromColors(
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 26),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 20,
                decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    borderRadius: BorderRadius.circular(4)),
              )
            ],
          ));
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(maxWidth: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(user?.imageUrl == ""
                      ? ConstantUrls.placeholderImageUrl
                      : user?.imageUrl ?? ConstantUrls.placeholderImageUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(user?.name ?? "Name",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.black.withOpacity(0.35))),
            ),
          ],
        ),
      ),
    );
  }
}
