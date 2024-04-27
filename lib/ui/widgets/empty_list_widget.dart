import 'package:flutter/material.dart';

import '../../commons/app_text_styles.dart';
import '../../configs/app_colors.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final RefreshCallback onRefresh;

  EmptyListWidget({this.text = 'Không có data', required this.onRefresh});

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
                    style: AppTextStyle.poppins18W800.copyWith(color: AppColors
                        .textGray),
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
