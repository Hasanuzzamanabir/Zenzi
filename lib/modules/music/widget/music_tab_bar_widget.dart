import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';

class MusicTabBarWidget extends StatefulWidget {
  const MusicTabBarWidget({super.key});

  @override
  State<MusicTabBarWidget> createState() => _MusicTabBarWidgetState();
}

class _MusicTabBarWidgetState extends State<MusicTabBarWidget> {
  final List<GlobalKey> _tabKeys = <GlobalKey>[];

  void _syncTabKeys(int tabCount) {
    while (_tabKeys.length < tabCount) {
      _tabKeys.add(GlobalKey());
    }
    if (_tabKeys.length > tabCount) {
      _tabKeys.removeRange(tabCount, _tabKeys.length);
    }
  }

  void _scrollSelectedTabIntoView(int selectedIndex) {
    if (selectedIndex < 0 || selectedIndex >= _tabKeys.length) {
      return;
    }

    final BuildContext? tabContext = _tabKeys[selectedIndex].currentContext;
    if (tabContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      tabContext,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicTabBarWidgetController>();

    return Obx(() {
      _syncTabKeys(controller.selectedTabs.length);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollSelectedTabIntoView(controller.selectedTabIndex.value);
      });

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
                      key: _tabKeys[selectedTabIndex],
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
