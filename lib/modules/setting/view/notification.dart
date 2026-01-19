import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/controller/notification_controller.dart';
import 'package:zenzi/modules/setting/widgets/notification_widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primarytext),
          onPressed: () => Get.back(),
        ),
        title: Text("Notification", style: AppTextStyle.h2),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              SizedBox(height: 24.h),
              Obx(
                () => NotificationWidgets(
                  title: 'Meditate',
                  subtitle: 'Get notify for meditation',
                  value: controller.meditateEnabled.value,
                  onChanged: controller.toggleMeditate,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => NotificationWidgets(
                  title: 'Sleep time',
                  subtitle: 'Get notify for sleeping time',
                  value: controller.sleepTimeEnabled.value,
                  onChanged: controller.toggleSleepTime,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => NotificationWidgets(
                  title: 'Exercise time',
                  subtitle: 'Get notify for breathing exercise',
                  value: controller.exerciseTimeEnabled.value,
                  onChanged: controller.toggleExerciseTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
