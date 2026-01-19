import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/favourite/controller/favourite_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/favourite/view/affirm.dart';
import 'package:zenzi/modules/favourite/view/favourite_music.dart';
import 'package:zenzi/modules/favourite/view/lessons_view.dart';

class FavouriteTabBarWidgetView extends StatelessWidget {
  const FavouriteTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavouriteTabBarWidgetController>();

    final List<Widget> tabViews = [LessonsView(), FavouriteMusic(), Affirm()];

    return Obx(() => tabViews[controller.selectedTabIndex.value]);
  }
}
