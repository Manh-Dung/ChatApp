import 'package:flutter/material.dart';

import '../../../commons/app_text_styles.dart';
import '../../../configs/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../components/app_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text("Please enter the email address linked to your account",
                  style: TextStyle(color: AppColors.white)),
              const SizedBox(height: 36),
              Container(
                height: 48,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: AppTextStyle.poppins16Medium
                        .copyWith(color: AppColors.textGray),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              AppWhiteButton(
                title: S.of(context).sign_in,
              ),
            ],
          ),
        ));
  }
}
