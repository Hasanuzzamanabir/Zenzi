// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.primarytext),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 8.w),
                  Text('Account setting', style: AppTextStyle.h2),
                ],
              ),
              SizedBox(height: 16.h),

              SizedBox(height: 24.h),

              // Edit Profile Button
              _buildMenuItem(
                title: 'Edit Profile',
                onTap: () {
                  Get.toNamed('/editProfile');
                },
              ),

              SizedBox(height: 16.h),

              // Update Password Button
              _buildMenuItem(
                title: 'Update Password',
                onTap: () {
                  Get.toNamed('/updatePassword');
                },
              ),

              SizedBox(height: 16.h),

              // Account Deletion Button
              _buildMenuItem(
                title: 'Account Deletion',
                onTap: () {
                  // Navigate to Account Deletion Page
                  Get.toNamed('/accountDeletion');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: Color(0xFFB87333),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
