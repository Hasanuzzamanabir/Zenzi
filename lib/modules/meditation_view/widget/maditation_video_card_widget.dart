import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';

class MaditationVideoCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String imageContent;
  final String? imageUrl;
  final VoidCallback? onTap;

  const MaditationVideoCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imageContent,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.backgroundhorizon,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.h4.copyWith(color: AppColors.primarytext),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.secondarycolor,
                  ),
                  softWrap: true,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Image.asset(
                      AppAssets.watch,
                      width: 12.w,
                      height: 12.h,
                      color: AppColors.darktext,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.darktext,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarydarker,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Watch Now',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.secondarycolor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.play_circle_fill,
                            size: 20.w,
                            color: AppColors.secondarycolor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: imageUrl != null && imageUrl!.trim().isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      height: 100.h,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          imageContent,
                          height: 100.h,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      imageContent,
                      height: 100.h,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
