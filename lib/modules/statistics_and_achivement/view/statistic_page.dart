import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/widgets/custom%20calender/custom_calender.dart';
import 'package:zenzi/modules/statistics_and_achivement/controller/activity_statistics_controller.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/buildstate_card.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/weekly_states_bar.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/profile_card.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ActivityStatisticsController>()
        ? Get.find<ActivityStatisticsController>()
        : Get.put(ActivityStatisticsController());

    return Obx(() {
      final stats = controller.statistics.value;

      if (controller.isLoading.value && stats == null) {
        return SizedBox(
          height: 480.h,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primarycolor),
          ),
        );
      }

      final weeklyData = stats?.weeklyChart ?? const [];
      final meditationData = weeklyData.map((e) => e.meditation).toList();
      final musicData = weeklyData.map((e) => e.music).toList();
      final breathingData = weeklyData.map((e) => e.breathing).toList();

      return RefreshIndicator(
        onRefresh: controller.fetchStatistics,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                ProfileCard(
                  color: AppColors.backgroundhorizon,
                  name: stats?.userInfo.name,
                  avatarUrl: stats?.userInfo.avatar,
                  levelTitle: stats?.userInfo.levelTitle,
                  points: stats?.userInfo.totalPoints,
                ),
                SizedBox(height: 20.h),
                CustomCalendar(
                  streakDates: stats?.streakCalendarDates ?? const [],
                ),
                SizedBox(height: 20.h),
                WeeklyStatsBar(
                  meditationData: meditationData,
                  musicData: musicData,
                  breathingData: breathingData,
                ),
                SizedBox(height: 20.h),
                StatCard(
                  title: 'Total Meditation Session',
                  value: '${stats?.totalMeditationSessions ?? 0}',
                  backgroundColor: AppColors.primarycolor,
                ),
                SizedBox(height: 16.h),
                StatCard(
                  title: 'Total Breathing Exercise',
                  value: '${stats?.totalBreathingDays ?? 0} days',
                  backgroundColor: AppColors.backgroundhorizon,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
