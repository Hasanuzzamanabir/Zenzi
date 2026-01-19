// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/music/view/play_music.dart';

class MusicCardController extends GetxController {
  var isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}

class MusicCardWidget extends StatelessWidget {
  MusicCardWidget({
    super.key,
    this.isFav = false,
    this.name,
    this.duration,
    this.isDvided = false,
  });

  final bool isFav;
  final String? name;
  final String? duration;
  final bool isDvided;
  final controller = Get.put(
    MusicCardController(),
    tag: UniqueKey().toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const PlayMusic());
            // Handle card tap if needed
          },
          child: ListTile(
            leading: GestureDetector(
              onTap: () => controller.toggleSelection(),
              child: Obx(
                () => Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: controller.isSelected.value
                        ? AppColors.playbuttoncolor1
                        : null,
                    border: Border.all(color: AppColors.secondarycolor),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
              ),
            ),
            title: Text(
              name ?? 'Relaxing Music',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              duration ?? '3:45 mins',
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Icon(isFav ? Icons.favorite : null, color: Colors.red),
          ),
        ),
        if (isDvided) Divider(),
      ],
    );
  }
}
