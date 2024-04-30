import 'package:flutter/material.dart';
import 'package:vinhcine/configs/app_colors.dart';
import 'package:vinhcine/models/entities/index.dart';
import 'package:vinhcine/network/constants/constant_urls.dart';

class UserWidget extends StatelessWidget {
  final UserModel? user;
  final VoidCallback onTap;

  const UserWidget({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
}
