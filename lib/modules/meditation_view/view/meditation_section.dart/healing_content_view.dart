import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/meditation_view/widget/maditation_video_card_widget.dart';
import 'package:zenzi/routes/app_routes.dart';

class HealingContentView extends StatelessWidget {
const HealingContentView({super.key});

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
                title: 'Meditation 101',
                subtitle: 'Techniques, Benefits, and a Beginner’s How-To',
                duration: '10 min',
                imageContent: AppAssets.medi,
                onTap: () {
                  Get.toNamed(AppRoute.getMeditationDetails());
                },
              ),
              SizedBox(height: 16.h),
              MaditationVideoCardWidget(
                title: 'Cardio Meditation',
                subtitle: 'Techniques for Beginners',
                duration: '10 min',
                imageContent: AppAssets.cardio,
                onTap: () {},
              ),
           
           
            
            ],
          ),
        ),
      ],
    );
  }
}
