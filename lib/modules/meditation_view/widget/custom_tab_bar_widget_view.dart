import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/meditation_view/controller/custom_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_section.dart/all_tab_content_view.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_section.dart/healing_content_view.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_section.dart/my_favourite_content_view.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_section.dart/stress_relief_content_view.dart';

class CustomTabBarWidgetView extends StatelessWidget {
  const CustomTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomTabBarWidgetController>();

    final List<Widget> tabViews = [
      AllTabContentView(),
      MyFavouriteContentView(),
      StressReliefContentView(),
      HealingContentView(),
     
    ];

    return Obx(() {
      return tabViews[controller.selectedTabIndex.value];
    });
  }
}
