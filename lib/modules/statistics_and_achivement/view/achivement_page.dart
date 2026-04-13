// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/statistics_and_achivement/controller/achievement_controller.dart';
import 'package:zenzi/modules/statistics_and_achivement/controller/activity_statistics_controller.dart';
import 'package:zenzi/modules/statistics_and_achivement/model/achievement_model.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/profile_card.dart';

class AchivementPage extends StatelessWidget {
  const AchivementPage({super.key});

  static const List<String> _localAchievementAssets = [
    'assets/image/achivement/yoga1.png',
    'assets/image/achivement/yoga2.png',
    'assets/image/achivement/yoga3.png',
    'assets/image/achivement/yoga4.png',
    'assets/image/achivement/yoga5.png',
    'assets/image/achivement/yoga6.png',
    'assets/image/achivement/yoga7.png',
    'assets/image/achivement/yoga8.png',
  ];

  @override
  Widget build(BuildContext context) {
    final achievementController = Get.isRegistered<AchievementController>()
        ? Get.find<AchievementController>()
        : Get.put(AchievementController());

    final statsController = Get.isRegistered<ActivityStatisticsController>()
        ? Get.find<ActivityStatisticsController>()
        : Get.put(ActivityStatisticsController());

    return Obx(() {
      final achievementData = achievementController.achievements.value;
      final stats = statsController.statistics.value;

      if (achievementController.isLoading.value && achievementData == null) {
        return SizedBox(
          height: 480.h,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primarycolor),
          ),
        );
      }

      final items = achievementData?.results ?? <AchievementItem>[];

      return RefreshIndicator(
        onRefresh: () async {
          await achievementController.fetchAchievements();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              ProfileCard(
                color: AppColors.congratsscrennbuttonclr,
                name: stats?.userInfo.name,
                avatarUrl: stats?.userInfo.avatar,
                levelTitle: stats?.userInfo.levelTitle,
                points: stats?.userInfo.totalPoints,
              ),
              SizedBox(height: 20.h),
              _buildAchievementGrid(items),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAchievementGrid(List<AchievementItem> achievements) {
    if (achievements.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Column(
            children: [
              Icon(
                Icons.emoji_events,
                size: 80.sp,
                color: AppColors.secondarytext.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Achievements Yet',
                style: TextStyle(
                  color: AppColors.primarytext,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Keep meditating to unlock achievements!',
                style: TextStyle(
                  color: AppColors.secondarytext,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return _buildAchievementBadge(achievements[index], index);
      },
    );
  }

  Widget _buildAchievementBadge(AchievementItem achievement, int index) {
    final imageAssetPath = _resolveAssetPath(index);

    return GestureDetector(
      onTap: () {
        Get.dialog(
          Dialog(
            backgroundColor: AppColors.primarydarker,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: _buildImage(imageAssetPath),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    achievement.name,
                    style: TextStyle(
                      color: AppColors.primarytext,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (achievement.description != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      achievement.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondarytext,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(imageAssetPath),
            if (!achievement.isUnlocked)
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Icon(
                    Icons.lock,
                    color: AppColors.primarytext,
                    size: 48.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageAssetPath) {
    if (imageAssetPath != null && imageAssetPath.isNotEmpty) {
      return Image.asset(
        imageAssetPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
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
  }

  String _resolveAssetPath(int index) {
    return _localAchievementAssets[index % _localAchievementAssets.length];
  }
}
