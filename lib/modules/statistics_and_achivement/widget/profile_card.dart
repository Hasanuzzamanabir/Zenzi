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
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.backgroundbasecolor.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 32.r,
            backgroundImage: const AssetImage(
              'assets/images/profile_picture.png',
            ),
          ),

          SizedBox(width: 14.w),

          /// Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Good Morning',
                  style: AppTextStyle.h4.copyWith(
                    color: AppColors.primarytext,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Steven Smith',
                  style: AppTextStyle.h2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: .spaceBetween,
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
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darktext,
                        borderRadius: BorderRadius.circular(16.r),
                        //
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

          /// Points Badge (Far Right)
        ],
      ),
    );
  }
}
