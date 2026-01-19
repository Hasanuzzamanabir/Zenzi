import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/music/view/music_section.dart/all_music_tab.dart';
import 'package:zenzi/modules/music/view/music_section.dart/my_fav.dart';

class MusicTabBarWidgetView extends StatelessWidget {
  const MusicTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicTabBarWidgetController>();

    final List<Widget> tabViews = [
      AllMusicTab(),
      MyFavTab(),
      Center(child: Text('Healing Tab Content')),
      Center(child: Text('Healing Tab Content')),
      Center(child: Text('Head Tab Content')),
    ];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
