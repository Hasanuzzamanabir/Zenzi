// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    this.image,
    this.icon,
    required this.title,
    required this.description,
    required this.time,
    this.backgroundColor = AppColors.textlink,
    this.iconColor,
    this.titleColor,
    this.descriptionColor,
    this.timeColor,
    required TextStyle style,
  });

  final String? image;
  final IconData? icon;
  final String title;
  final String description;
  final String time;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? timeColor;

  @override
  Widget build(BuildContext context) {
    // Determine if background is primary or secondary color
    final bool isPrimaryBackground =
        backgroundColor == AppColors.textlink ||
        backgroundColor == AppColors.primarylight;

    // Set colors based on background: white for primary, black for secondary
    final Color computedIconColor =
        iconColor ??
        (isPrimaryBackground
            ? Colors.white.withOpacity(0.9)
            : Colors.black.withOpacity(0.9));
    final Color computedTitleColor =
        titleColor ?? (isPrimaryBackground ? Colors.white : Colors.black);
    final Color computedDescriptionColor =
        descriptionColor ??
        (isPrimaryBackground
            ? Colors.white.withOpacity(0.85)
            : Colors.black.withOpacity(0.85));
    final Color computedTimeColor =
        timeColor ??
        (isPrimaryBackground
            ? Colors.white.withOpacity(0.7)
            : Colors.black.withOpacity(0.7));

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primarylight,
        border: AppColors.secondarycolor != null
            ? Border.all(color: AppColors.secondarycolor, width: 1.w)
            : null,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon or Image
          Image.asset(
            image ?? AppAssets.notifySun,
            color: computedIconColor,
            width: 24.sp,
            height: 24.sp,
          ),
          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: computedTitleColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    color: computedDescriptionColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),

                // Time
                Text(
                  time,
                  style: TextStyle(
                    color: computedTimeColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
