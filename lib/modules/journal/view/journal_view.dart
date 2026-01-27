import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/journal/controller/journal_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/journal/widgets/journal_tab_bar_widget.dart';
import 'package:zenzi/modules/journal/widgets/journal_tab_bar_widget_view.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JournalTabBarWidgetController());

    return ThemedScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),

                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Gratitude Journal",
                      style: AppTextStyle.h4.copyWith(
                        color: AppColors.primarytext,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            JournaTabBarWidget(),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(child: JournalTabBarWidgetView()),
            ),
          ],
        ),
      ),
    );
  }
}
