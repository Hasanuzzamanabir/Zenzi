// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/notification/widgets/notification_tab_bar_widget.dart';
import 'package:zenzi/modules/notification/widgets/notification_tab_bar_widget_view.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationTabBarWidgetController());

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondarycolor,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
      ),
    );
  }
}
