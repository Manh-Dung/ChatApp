import 'package:flutter/material.dart';

import '../../../../../../configs/app_colors.dart';
import '../../../../../../configs/app_uri.dart';
import '../../../../../../router/routers.dart';

class ListUserGemini extends StatelessWidget {
  const ListUserGemini({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routers.aiChat);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.white,
              backgroundImage: AssetImage(XR().assetsImage.ic_gemini),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gemini",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.black),
                ),
                Text("AI",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black.withOpacity(0.5))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
