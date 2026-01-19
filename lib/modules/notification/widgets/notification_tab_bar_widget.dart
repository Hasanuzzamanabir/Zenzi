import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';

class NotificationTabBarWidget extends StatelessWidget {
  const NotificationTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationTabBarWidgetController>();

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
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : const Color(0xFF9A9A9A),
                            width: 1.5,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.selectedTabs[selectedTabIndex],
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isSelected
                                    ? AppColors.primarytext
                                    : AppColors.textlink,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (controller.tabCounts[selectedTabIndex] > 0) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primarytext
                                      : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 24.w,
                                  minHeight: 24.h,
                                ),
                                child: Center(
                                  child: Text(
                                    '${controller.tabCounts[selectedTabIndex]}',
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.textlink
                                          : AppColors.primarytext,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
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
