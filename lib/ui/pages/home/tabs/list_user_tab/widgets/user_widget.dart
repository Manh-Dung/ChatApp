import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vinhcine/configs/app_colors.dart';
import 'package:vinhcine/models/entities/index.dart';
import 'package:vinhcine/network/constants/constant_urls.dart';

class UserWidget extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onTap;
  final bool? isShimmer;

  const UserWidget({super.key, this.user, this.onTap, this.isShimmer});

  @override
  Widget build(BuildContext context) {
    if (isShimmer ?? false) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.baseColor,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _textPlaceholder(MediaQuery.of(context).size.width * 0.5),
                      const SizedBox(height: 4),
                      _textPlaceholder(MediaQuery.of(context).size.width * 0.4),
                    ],
                  ),
                ],
              ),
            ),
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highlightColor),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.baseColor,
                backgroundImage: NetworkImage(user?.imageUrl == ""
                    ? ConstantUrls.placeholderImageUrl
                    : user?.imageUrl ?? ConstantUrls.placeholderImageUrl),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.email ?? "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: AppColors.black),
                  ),
                  Text(user?.name ?? "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black.withOpacity(0.5))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textPlaceholder(double width) {
    return Container(
      height: 17,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.baseColor,
      ),
    );
  }
}
