// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:zenzi/core/theme/app_colors.dart';
// import 'package:zenzi/core/theme/app_text_style.dart';
// import 'package:zenzi/core/widgets/themed_scaffold.dart';
// import 'package:zenzi/modules/download/controller/download_tab_bar_widget_controller.dart';
// import 'package:zenzi/modules/download/widgets/download_tab_bar_widget.dart';
// import 'package:zenzi/modules/download/widgets/download_tab_bar_widget_view.dart';

// class DownloadView extends StatelessWidget {
//   const DownloadView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DownloadTabBarWidgetController());

//     return ThemedScaffold(
//       body: Padding(
//         padding: EdgeInsets.all(16.h),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 60.h),
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: AppColors.secondarycolor,
//                     size: 24.sp,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),

//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       "Downloads",
//                       style: AppTextStyle.h4.copyWith(
//                         color: AppColors.primarytext,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             DownloadTabBarWidget(),
//             SizedBox(height: 16.h),
//             Expanded(
//               child: SingleChildScrollView(child: DownloadTabBarWidgetView()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/download/controller/download_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/download/widgets/download_tab_bar_widget.dart';
import 'package:zenzi/modules/download/widgets/download_tab_bar_widget_view.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DownloadTabBarWidgetController());

    return ThemedScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            // ✅ AppBar-like header
            SizedBox(
              height: 60.h,
              child: Row(
                children: [
                  // LEFT: Back button
                  SizedBox(
                    width: 48.w,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.secondarycolor,
                        size: 24.sp,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // CENTER: Title (perfect center)
                  Expanded(
                    child: Center(
                      child: Text(
                        "Downloads",
                        style: AppTextStyle.h4.copyWith(
                          color: AppColors.primarytext,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  // RIGHT: Empty space (same width as left)
                  SizedBox(width: 48.w),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            DownloadTabBarWidget(),
            SizedBox(height: 16.h),

            Expanded(
              child: SingleChildScrollView(child: DownloadTabBarWidgetView()),
            ),
          ],
        ),
      ),
    );
  }
}
