// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

Widget iconBox(String asset) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.backgroundcolor,
      borderRadius: BorderRadius.circular(8.r),
    ),
    padding: EdgeInsets.all(8.w),
    child: Image.asset(asset, width: 30.w, height: 30.h),
  );
}

/// MOOD WIDGET - Reusable stateless widget for mood selection
/// Works with any controller - no business logic inside
class MoodWidget extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodWidget({
    super.key,
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primarycolor.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primarycolor : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: isSelected ? 32.sp : 28.sp)),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? AppColors.primarycolor
                    : AppColors.primarytext,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
