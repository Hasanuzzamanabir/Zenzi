// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/widgets/build_menu_item.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Account setting',
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              // Edit Profile Button
              BuildMenuItem(
                title: 'Edit Profile',
                onTap: () {
                  Get.toNamed('/editProfile');
                },
              ),

              SizedBox(height: 16.h),

              // Update Password Button
              BuildMenuItem(
                title: 'Update Password',
                onTap: () {
                  Get.toNamed('/updatePassword');
                },
              ),

              SizedBox(height: 16.h),

              // Account Deletion Button
              BuildMenuItem(
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
}
