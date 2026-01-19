// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/notification/widgets/notification_tab_bar_widget.dart';
import 'package:zenzi/modules/notification/widgets/notification_tab_bar_widget_view.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationTabBarWidgetController());

    return Scaffold(
      backgroundColor: AppColors.primarydarker,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.secondarycolor,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Downloads",
                      style: AppTextStyle.h4.copyWith(
                        color: AppColors.primarytext,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            NotificationTabBarWidget(),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: NotificationTabBarWidgetView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
