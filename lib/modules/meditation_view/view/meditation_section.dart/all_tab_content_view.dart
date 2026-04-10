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
        return const Center(child: CircularProgressIndicator());
      }

      final meditations = controller.filteredMeditations;

      if (controller.hasError.value && meditations.isEmpty) {
        return const Center(child: Text('Unable to load meditations'));
      }

      if (meditations.isEmpty) {
        return const Center(child: Text('No meditations found'));
      }

      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 30.h),
        itemCount: meditations.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final meditation = meditations[index];

          return MaditationVideoCardWidget(
            title: meditation.title,
            subtitle: meditation.description.isNotEmpty
                ? meditation.description
                : 'Guided meditation',
            duration: meditation.durationLabel,
            imageContent: _fallbackAssetForIndex(index),
            onTap: () {
              Get.toNamed(AppRoute.getMeditationDetails());
            },
          );
        },
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
