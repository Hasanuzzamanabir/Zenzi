import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';

class MusicTabBarWidget extends StatelessWidget {
  const MusicTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicTabBarWidgetController>();

    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(controller.selectedTabs.length, (
            selectedTabIndex,
          ) {
            final isSelected =
                controller.selectedTabIndex.value == selectedTabIndex;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => controller.selectTab(selectedTabIndex),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarycolor
                              : AppColors.primarylight,
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Center(
                          child: Text(
                            controller.selectedTabs[selectedTabIndex],
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF1F2937),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 2.h,
                    //   width: 40.w,
                    //   decoration: BoxDecoration(
                    //     color: isSelected
                    //         ? const Color(0xFF0076F5)
                    //         : Colors.transparent,
                    //     borderRadius: BorderRadius.circular(1.r),
                    //   ),
                    // ),
                  ],
                ),

                if (selectedTabIndex != controller.selectedTabs.length - 1)
                  SizedBox(width: 10.w),
              ],
            );
          }),
        ),
      );
    });
  }
}
