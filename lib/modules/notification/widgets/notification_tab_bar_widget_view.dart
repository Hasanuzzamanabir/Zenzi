import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/notification/view/all.dart';
import 'package:zenzi/modules/notification/view/reminders.dart';
import 'package:zenzi/modules/notification/view/unread.dart';
import 'package:zenzi/modules/notification/view/updates.dart';

class NotificationTabBarWidgetView extends StatelessWidget {
  const NotificationTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationTabBarWidgetController>();

    final List<Widget> tabViews = [
      AllTab(),
      UnreadTab(),
      RemindersTab(),
      UpdatesTab(),
      //MyFavTab(),
    ];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
