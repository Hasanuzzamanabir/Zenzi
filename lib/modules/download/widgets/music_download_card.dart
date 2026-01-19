import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class MusicDownloadCardController extends GetxController {
  var isSelected = false.obs;

  var isDeleteMode = false.obs;

  void setDeleteMode() {
    isDeleteMode.value = !isDeleteMode.value;
  }

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}

class MusicDownloadCardWidget extends StatelessWidget {
  MusicDownloadCardWidget({
    super.key,
    this.isFav = false,
    this.name,
    this.duration,
    this.isDvided = false,
    this.isDeleteMode = false,
  });

  final bool isFav;
  final String? name;
  final String? duration;
  final bool isDvided;
  final bool isDeleteMode;

  final controller = Get.put(
    MusicDownloadCardController(),
    tag: UniqueKey().toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,

          /// ❌ left empty
          background: const SizedBox(),

          /// ✅ RIGHT SLIDE DELETE BG
          secondaryBackground: Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.textfieldiconcolor, // dark bg (same vibe)
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.w),
            child: const Icon(Icons.delete, color: Colors.red, size: 24),
          ),

          onDismissed: (_) {
            //
          },

          /// ✅ MAIN CARD (unchanged UI)
          child: GestureDetector(
            onLongPress: () => controller.setDeleteMode(),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.primarydarker,
              ),
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
                      child: const Icon(Icons.play_arrow, color: Colors.white),
                    ),
                  ),
                ),
                title: Text(
                  name ?? 'Relaxing Music',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  duration ?? '3:45 mins',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Icon(
                  isFav ? Icons.favorite : null,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),

        if (isDvided) const Divider(),
      ],
    );
  }
}
