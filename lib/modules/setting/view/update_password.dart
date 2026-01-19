import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Header Row
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primarytext,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(width: 8.w),
                    Text('Update password', style: AppTextStyle.h2),
                  ],
                ),

                SizedBox(height: 24.h),

                // Title
                Text(
                  'Update Your Password',
                  style: AppTextStyle.h2.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Provide your basics information',
                  style: AppTextStyle.h5.copyWith(
                    color: AppColors.secondarycolor,
                    fontSize: 13.sp,
                  ),
                ),

                SizedBox(height: 32.h),

                // Current Password Label
                Text(
                  'Current Password',
                  style: AppTextStyle.h5.copyWith(
                    color: AppColors.primarytext,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 8.h),

                // Current Password Field
                AppTextField(
                  hintText: '************',
                  controller: currentPasswordController,
                  isPassword: true,
                ),

                SizedBox(height: 20.h),

                // New Password Label
                Text(
                  'New password',
                  style: AppTextStyle.h5.copyWith(
                    color: AppColors.primarytext,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 8.h),

                // New Password Field
                AppTextField(
                  hintText: '',
                  controller: newPasswordController,
                  isPassword: true,
                ),

                SizedBox(height: 20.h),

                // Confirm New Password Label
                Text(
                  'Confirm New Password',
                  style: AppTextStyle.h5.copyWith(
                    color: AppColors.primarytext,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 8.h),

                // Confirm New Password Field
                AppTextField(
                  hintText: '',
                  controller: confirmPasswordController,
                  isPassword: true,
                ),

                SizedBox(height: 40.h),

                // Save Button
                AppButton(
                  title: 'Save',
                  onTap: () {
                    // Handle password update
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
