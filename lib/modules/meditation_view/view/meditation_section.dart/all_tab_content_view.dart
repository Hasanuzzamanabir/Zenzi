import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/meditation_view/controller/meditation_controller.dart';
import 'package:zenzi/modules/meditation_view/widget/maditation_video_card_widget.dart';
import 'package:zenzi/routes/app_routes.dart';

class AllTabContentView extends StatelessWidget {
  const AllTabContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final MeditationController controller = Get.find<MeditationController>();

    return Obx(() {
      if (controller.isLoading.value && controller.meditationList.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final meditations = controller.filteredMeditations;

      if (controller.hasError.value && meditations.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: const Center(child: Text('Unable to load meditations')),
        );
      }

      if (meditations.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: const Center(child: Text('No meditations found')),
        );
      }

      return Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                for (int index = 0; index < meditations.length; index++) ...[
                  MaditationVideoCardWidget(
                    title: meditations[index].title,
                    subtitle: meditations[index].description.isNotEmpty
                        ? meditations[index].description
                        : 'Guided meditation',
                    duration: meditations[index].durationLabel,
                    imageContent: _fallbackAssetForIndex(index),
                    onTap: () {
                      Get.toNamed(AppRoute.getMeditationDetails());
                    },
                  ),
                  if (index != meditations.length - 1) SizedBox(height: 16.h),
                ],
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      );
    });
  }

  String _fallbackAssetForIndex(int index) {
    const fallbackAssets = [
      AppAssets.medi,
      AppAssets.cardio,
      AppAssets.deep,
      AppAssets.meditationbg,
    ];

    return fallbackAssets[index % fallbackAssets.length];
  }
}
