import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class FavoriteCard extends StatelessWidget {
  final Widget image;

  const FavoriteCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.w,
          width: 90.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.primarylight,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(child: image),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
