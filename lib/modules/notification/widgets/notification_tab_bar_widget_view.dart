import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/music/view/music_section.dart/my_fav.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/notification/view/all.dart';

class NotificationTabBarWidgetView extends StatelessWidget {
  const NotificationTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationTabBarWidgetController>();

    final List<Widget> tabViews = [
      AllTab(),
      MyFavTab(),
      Center(child: Text('Healing Tab Content')),
      Center(child: Text('Healing Tab Content')),
      Center(child: Text('Head Tab Content')),
    ];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
