import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';

import 'package:zenzi/modules/statistics_and_achivement/controller/statistic_and_achivement_tab_bar_widget_controller.dart';

class StatisticAndAchivementWidget extends StatelessWidget {
  const StatisticAndAchivementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticAndAchivementTabBarWidgetController>();

    return Obx(() {
      return Container(
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.primarylight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.backgroundbasecolor.withOpacity(0.8),
            width: 1.5,
          ),
        ),
        child: Row(
          children: List.generate(controller.selectedTabs.length, (
            selectedTabIndex,
          ) {
            final isSelected =
                controller.selectedTabIndex.value == selectedTabIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(selectedTabIndex),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.coreprimarydark
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 11.h,
                  ),
                  child: Center(
                    child: Text(
                      controller.selectedTabs[selectedTabIndex],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isSelected
                            ? Colors.white
                            : AppColors.componentgreenish,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
