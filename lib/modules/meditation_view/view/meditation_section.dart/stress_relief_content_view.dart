import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/meditation_view/widget/maditation_video_card_widget.dart';

class StressReliefContentView extends StatelessWidget {
  const StressReliefContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              MaditationVideoCardWidget(
                title: 'Cardio Meditation',
                subtitle: 'Techniques for Beginners',
                duration: '10 min',
                imageContent: AppAssets.cardio,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              MaditationVideoCardWidget(
                title: 'Meditation 101',
                subtitle: 'Techniques for Beginners',
                duration: '10 min',
                imageContent: AppAssets.deep,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              MaditationVideoCardWidget(
                title: 'Meditation 101',
                subtitle: 'Techniques for Beginners',
                duration: '10 min',
                imageContent: AppAssets.meditationbg,
                onTap: () {},
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ],
    );
  }
}
