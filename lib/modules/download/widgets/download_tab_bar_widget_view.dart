import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/download/controller/download_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/download/view/download_lesson.dart';
import 'package:zenzi/modules/download/view/download_music.dart';

class DownloadTabBarWidgetView extends StatelessWidget {
  const DownloadTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DownloadTabBarWidgetController>();

    final List<Widget> tabViews = [DownloadLessonPage(), DownloadMusicPage()];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
