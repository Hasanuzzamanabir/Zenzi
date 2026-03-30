import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class TextLabel extends StatelessWidget {
  final String text;
  const TextLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTextStyle.h5.copyWith(
          color: AppColors.primarytext,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
