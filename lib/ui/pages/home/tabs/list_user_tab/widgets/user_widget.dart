import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                    user?.imageUrl ?? ConstantUrls.placeholderImageUrl),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user?.email ?? "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(user?.name ?? "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
