import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/favourite/controller/favourite_lessons_controller.dart';
import 'package:zenzi/modules/meditation_view/widget/maditation_video_card_widget.dart';
import 'package:zenzi/routes/app_routes.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavouriteLessonsController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.lessonsList.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: const Center(child: Text('No favorite lessons found!')),
        );
      }

      return Column(
        children: [
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.lessonsList.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final lesson = controller.lessonsList[index];

              return MaditationVideoCardWidget(
                title: lesson.title,
                subtitle: lesson.description,
                duration: lesson.durationLabel,
                imageContent: AppAssets.medi,
                imageUrl: lesson.thumbnailUrl,
                onTap: () {
                  Get.toNamed(
                    AppRoute.getMeditationDetails(),
                    arguments: lesson.id,
                  );
                },
              );
            },
          ),
          SizedBox(height: 30.h),
        ],
      );
    });
  }
}
