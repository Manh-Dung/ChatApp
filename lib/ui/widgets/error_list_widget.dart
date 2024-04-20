import 'package:flutter/material.dart';
import 'package:vinhcine/commons/app_colors.dart';
import 'package:vinhcine/commons/app_text_styles.dart';

class ErrorListWidget extends StatelessWidget {
  final String text;
  final RefreshCallback onRefresh;

  ErrorListWidget({this.text = 'Đã xảy ra lỗi', required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Text(
                    text,
                    style: AppTextStyle.roboto18W800.copyWith(color: AppColors.textGray),
                  ),
                ),
              );
            },
            itemCount: 1,
          ),
          onRefresh: onRefresh),
    );
  }
}
