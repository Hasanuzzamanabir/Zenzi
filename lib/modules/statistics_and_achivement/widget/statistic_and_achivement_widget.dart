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
        decoration: BoxDecoration(
          color: AppColors.primarylight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        // padding: EdgeInsets.s(4.w),
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
                    horizontal: 32.w,
                    vertical: 10.h,
                  ),
                  child: Center(
                    child: Text(
                      controller.selectedTabs[selectedTabIndex],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isSelected
                            ? Colors.white
                            : AppColors.componentgreenish,
                        fontWeight: FontWeight.w500,
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
