import 'package:flutter/material.dart';
import 'package:vinhcine/models/entities/index.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("https://cdn.pixabay"
                    ".com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
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
