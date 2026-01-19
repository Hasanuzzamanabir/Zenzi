import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Widget image;
  final Color textColor;
  final Color iconBgColor;

  const StatItem({
    super.key,
    required this.value,
    required this.label,
    required this.image,
    required this.textColor,
    this.iconBgColor = AppColors.secondarycolor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
          child: Center(child: image),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondarycolor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
