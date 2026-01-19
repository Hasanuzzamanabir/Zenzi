// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class CustomShareBottomSheet {
  static void show(BuildContext context, String textToShare) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.coreprimarydark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.secondarytext.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 0.85,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildShareOption(
                  Icons.link,
                  'Copy url',
                  AppColors.primarycolor,
                ),
                _buildShareOption(Icons.send, 'Direct', Color(0xFFE4405F)),
                _buildShareOption(
                  Icons.telegram,
                  'Telegram',
                  Color(0xFF0088CC),
                ),
                _buildShareOption(Icons.message, 'Message', Color(0xFFFF6B9D)),
                _buildShareOption(
                  Icons.flutter_dash,
                  'Twitter',
                  Color(0xFF1DA1F2),
                ),
                _buildShareOption(
                  Icons.chat_bubble,
                  'Messages',
                  Color(0xFF34B7F1),
                ),
                _buildShareOption(
                  Icons.more_horiz,
                  'More',
                  AppColors.secondarytext,
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  static Widget _buildShareOption(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 28.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(color: AppColors.primarytext, fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
