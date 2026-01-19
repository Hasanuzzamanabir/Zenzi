// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/profile_card.dart';

class AchivementPage extends StatelessWidget {
  const AchivementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          ProfileCard(color: AppColors.congratsscrennbuttonclr),
          SizedBox(height: 20.h),
          _buildAchievementGrid(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildAchievementGrid() {
    final achievements = [
      AppAssets.yoga1,
      AppAssets.yoga2,
      AppAssets.yoga3,
      AppAssets.yoga4,
      AppAssets.yoga5,
      AppAssets.yoga6,
      AppAssets.yoga7,
      AppAssets.yoga8,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return _buildAchievementBadge(achievements[index]);
      },
    );
  }

  Widget _buildAchievementBadge(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.backgroundhorizon,
            child: Center(
              child: Icon(
                Icons.emoji_events,
                size: 60.sp,
                color: AppColors.secondarytext.withOpacity(0.3),
              ),
            ),
          );
        },
      ),
    );
  }
}
