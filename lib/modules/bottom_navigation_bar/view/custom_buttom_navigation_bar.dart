// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/bottom_navigation_bar/controller/custom_bottom_navigation_bar_controller.dart';
import 'package:zenzi/modules/breath_page/view/breath_page_view.dart';
import 'package:zenzi/modules/home/view/home_view.dart';
import 'package:zenzi/modules/journal/view/journal_view.dart';
import 'package:zenzi/modules/more/view/more_option.dart';
import 'package:zenzi/modules/music/view/music_page.dart';

class CustomButtomNavigationBar extends StatelessWidget {
  final CustomBottomNavigationBarController controller = Get.put(
    CustomBottomNavigationBarController(),
  );

  final List<Widget> pages = [
    HomeView(),
    JournalView(),
    MusicPage(),
    BreathPageView(),
    MoreOption(),
  ];
  CustomButtomNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: AppColors.navbackground,
            border: Border(
              top: BorderSide(color: AppColors.unselectednavicon, width: 0),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.navbackground,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTabIndex,
            selectedItemColor: AppColors.unselectednavicon,
            unselectedItemColor: AppColors.unselectednavicon.withOpacity(0.5),
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 0
                        ? AppColors.primarycolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.selectedIndex.value == 0
                          ? AppColors.navbackground
                          : AppColors.unselectednavicon.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.home,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 1
                        ? AppColors.primarycolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.selectedIndex.value == 1
                          ? AppColors.navbackground
                          : AppColors.unselectednavicon.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.book,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ),
                label: 'Journal',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 2
                        ? AppColors.primarycolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.selectedIndex.value == 2
                          ? AppColors.navbackground
                          : AppColors.unselectednavicon.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.music,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ),
                label: 'Music',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 3
                        ? AppColors.primarycolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.selectedIndex.value == 3
                          ? AppColors.navbackground
                          : AppColors.unselectednavicon.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.pulmonology,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ),
                label: 'Breathe',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 4
                        ? AppColors.primarycolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.selectedIndex.value == 4
                          ? AppColors.navbackground
                          : AppColors.unselectednavicon.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.more,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
