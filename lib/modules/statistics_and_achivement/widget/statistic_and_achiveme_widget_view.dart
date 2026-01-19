import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zenzi/modules/statistics_and_achivement/controller/statistic_and_achivement_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/statistics_and_achivement/view/achivement_page.dart';
import 'package:zenzi/modules/statistics_and_achivement/view/statistic_page.dart';

class StatisticAndAchivementWidgetView extends StatelessWidget {
  const StatisticAndAchivementWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticAndAchivementTabBarWidgetController>();

    final List<Widget> tabViews = [StatisticPage(), AchivementPage()];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
