import 'package:flutter/material.dart';
import 'package:vinhcine/models/entities/index.dart';

class UserWidget extends StatelessWidget {
  final UserModel? user;
  final VoidCallback onTap;

  const UserWidget({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user?.name ?? "User name",
        style: TextStyle(color: Colors.black),
      ),
      onTap: onTap,
    );
  }
}
