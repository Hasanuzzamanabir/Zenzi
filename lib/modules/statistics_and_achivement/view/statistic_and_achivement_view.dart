import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/statistics_and_achivement/controller/statistic_and_achivement_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/statistic_and_achiveme_widget_view.dart';
import 'package:zenzi/modules/statistics_and_achivement/widget/statistic_and_achivement_widget.dart';

class StatisticAndAchivementView extends StatelessWidget {
  const StatisticAndAchivementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticAndAchivementTabBarWidgetController());
    final int currentHour = DateTime.now().hour;
    final bool isDay = currentHour >= 6 && currentHour < 18;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primarytext),
          onPressed: () => Get.back(),
        ),
        title: Text("Statistics & Achievement", style: AppTextStyle.h2),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDay ? AppColors.primarydarker : null,
          gradient: isDay
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.appnightmode1, AppColors.appnightmode2],
                ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              StatisticAndAchivementWidget(),
              SizedBox(height: 16.h),
              Expanded(
                child: SingleChildScrollView(
                  child: StatisticAndAchivementWidgetView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
