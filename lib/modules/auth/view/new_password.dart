import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/modules/auth/view/log_in_view.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondarycolor),
          onPressed: () => Get.back(),
        ),
        // title: Text(
        //   "Notification",
        //   style: AppTextStyle.h2.copyWith(
        //     fontSize: 20.sp,
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 52.h),
                Text('New Password', style: AppTextStyle.h2),

                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create new Password',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),
                ),
                SizedBox(height: 9.h),
                AppTextField(
                  hintText: 'Enter your email',
                  controller: TextEditingController(),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Re-Type Password',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),
                ),
                SizedBox(height: 9.h),
                AppTextField(
                  hintText: 'Enter your email',
                  controller: TextEditingController(),
                ),
                SizedBox(height: 30.h),
                AppButton(
                  title: 'Save',
                  onTap: () {
                    Get.to(const LogInView());
                  },
                ),
              ],
            ),
          ),
        ),

        // Back arrow button
        // Positioned(
        //   left: 16,
        //   top: 0,
        //   child: IconButton(
        //     padding: EdgeInsets.zero,
        //     alignment: Alignment.centerLeft,
        //     icon: const Icon(Icons.arrow_back),
        //     color: AppColors.secondarycolor,
        //     onPressed: () => Get.back(),
        //   ),
        // ),
      ),
    );
  }
}
