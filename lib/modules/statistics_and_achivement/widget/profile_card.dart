import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class ProfileCard extends StatelessWidget {
  final Color color;
  const ProfileCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.backgroundbasecolor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage(
              'assets/images/profile_picture.png',
            ),
          ),

          SizedBox(width: 12.w),

          /// Text Section (IMPORTANT)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Good Morning',
                  style: AppTextStyle.h4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Steven Smith',
                  style: AppTextStyle.h2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level: Grounded',
                      style: AppTextStyle.bodyMediumBold.copyWith(
                        color: AppColors.secondarycolor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.componentgreenish,
                        borderRadius: BorderRadius.circular(12.r),
                      ),

                      child: Text(
                        '598 pts',
                        style: AppTextStyle.h3.copyWith(
                          color: AppColors.secondarycolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          /// Points Badge
        ],
      ),
    );
  }
}
