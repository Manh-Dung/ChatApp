import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../configs/app_colors.dart';
import '../../../../../../models/entities/index.dart';
import '../../../../../../network/constants/constant_urls.dart';
import 'list_user_button.dart';

class ListUserHeader extends StatelessWidget {
  final UserModel? user;
  final bool? isShimmer;

  const ListUserHeader({super.key, this.user, this.isShimmer});

  @override
  Widget build(BuildContext context) {
    if (isShimmer ?? false) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Shimmer.fromColors(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 20),
                    const SizedBox(width: 12),
                    Container(
                        height: 24,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.baseColor,
                            borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                Row(
                  children: [
                    ListUserButton(onPressed: () {}, icon: Icons.camera_alt),
                    const SizedBox(width: 12),
                    ListUserButton(onPressed: () {}, icon: Icons.edit),
                  ],
                )
              ],
            ),
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highlightColor),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user?.imageUrl == ""
                    ? ConstantUrls.placeholderImageUrl
                    : user?.imageUrl ?? ConstantUrls.placeholderImageUrl),
              ),
              const SizedBox(width: 12),
              Text("Chats",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
            ],
          ),
          Row(
            children: [
              ListUserButton(onPressed: () {}, icon: Icons.camera_alt),
              const SizedBox(width: 12),
              ListUserButton(onPressed: () {}, icon: Icons.edit),
            ],
          )
        ],
      ),
    );
  }
}
