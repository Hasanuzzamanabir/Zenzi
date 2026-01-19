// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class AccountDeletion extends StatelessWidget {
  const AccountDeletion({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();

    return ThemedScaffold(
      body: SafeArea(
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
                    icon: Icon(Icons.arrow_back, color: AppColors.primarytext),
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(width: 8.w),
                  Text('Account deletion', style: AppTextStyle.h2),
                ],
              ),

              SizedBox(height: 24.h),

              // Warning Text
              Text(
                'Deleting your account is permanent. All your data will be removed and cannot be recovered.',
                style: AppTextStyle.h5.copyWith(
                  color: Color(0xFFD4A574),
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 32.h),

              // Enter Password Label
              Text(
                'Enter Password',
                style: AppTextStyle.h5.copyWith(
                  color: AppColors.primarytext,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 12.h),

              // Password Field
              AppTextField(
                hintText: '**********',
                controller: passwordController,
                isPassword: true,
              ),

              SizedBox(height: 12.h),

              // Info Text with Bullet Point
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h, right: 8.w),
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondarycolor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'To Delete your account please enter your password',
                      style: AppTextStyle.h5.copyWith(
                        color: AppColors.secondarycolor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Delete Button (Red)
              AppButton(
                title: 'Delete',
                backgroundColor: Color(0xFFFF4757),
                onTap: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.skysunrise,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: AppColors.secondarycolor, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are You Sure?',
                style: AppTextStyle.h2.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Account will be Deleted Permanently',
                style: AppTextStyle.h5.copyWith(fontSize: 14.sp, height: 1.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFD2E8FA),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Handle actual deletion
                        Get.back();
                        // Add deletion logic here
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFB3748),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Delete',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }
}
