import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/journal/controller/journal_tab_bar_widget_controller.dart';

class JournaTabBarWidget extends StatelessWidget {
  const JournaTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalTabBarWidgetController>();

    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primarylight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        //padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                            : const Color(0xFF6B5D4F),
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
