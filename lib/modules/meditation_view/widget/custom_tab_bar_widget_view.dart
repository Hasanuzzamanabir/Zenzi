import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/meditation_view/controller/custom_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/meditation_view/view/meditation_section.dart/all_tab_content_view.dart';

class CustomTabBarWidgetView extends StatelessWidget {
  const CustomTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CustomTabBarWidgetController>();
    return const AllTabContentView();
  }
}
