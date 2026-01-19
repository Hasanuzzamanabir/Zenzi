import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/journal/controller/journal_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/journal/view/optionPage/daily_page.dart';
import 'package:zenzi/modules/journal/view/optionPage/history_page.dart';

class JournalTabBarWidgetView extends StatelessWidget {
  const JournalTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalTabBarWidgetController>();

    final List<Widget> tabViews = [DailyPage(), HistoryPage()];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
