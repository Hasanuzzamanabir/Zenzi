import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/widgets/custom%20calender/custom_calender.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/buildstate_card.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/weekly_states_bar.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/profile_card.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            ProfileCard(color: AppColors.backgroundhorizon),
            SizedBox(height: 20.h),
            CustomCalendar(),
            SizedBox(height: 20.h),
            WeeklyStatsBar(
              meditationData: [20, 35, 40, 55, 70, 45, 60],
              musicData: [10, 15, 25, 30, 35, 20, 25],
            ),
            SizedBox(height: 20.h),
            StatCard(
              title: 'Total Meditation Session',
              value: '46',
              backgroundColor: AppColors.primarycolor,
            ),
            SizedBox(height: 16.h),
            StatCard(
              title: 'Total Breathing Exercise',
              value: '65 days',
              backgroundColor: AppColors.backgroundhorizon,
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
