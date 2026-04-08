// ignore_for_file: dead_code, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/auth/view/login/controller/login_controller.dart';

import 'package:zenzi/modules/more/widget/seeting_item.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';
import 'package:zenzi/routes/app_routes.dart';

class MoreOption extends StatefulWidget {
  const MoreOption({super.key});

  @override
  State<MoreOption> createState() => _MoreOptionState();
}

class _MoreOptionState extends State<MoreOption> {
  final LoginController loginController = Get.put(LoginController());

  final EditProfileController editProfileController = Get.put(
    EditProfileController(),
  );

  @override
  void initState() {
    super.initState();
    editProfileController.fetchProfile();
  }

  String? resolveAvatarUrl(String? url) {
    if (url == null || url.trim().isEmpty) return null;

    final uri = Uri.tryParse(url);
    return (uri != null && uri.hasScheme)
        ? url
        : '${BaseUrl.baseUrl}/${url.replaceFirst(RegExp(r'^/+'), '')}';
  }

  @override
  Widget build(BuildContext context) {
    bool isSubscribed = false; // Change to true when user subscribes

    return ThemedScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                // Settings Section
                Container(
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.coreprimarydark,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.primarytext, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.access_alarm,
                        //
                        title: 'Set notify Time',
                        onTap: () {
                          Get.toNamed(AppRoute.getSetTimeView());
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.notifications_none,
                        title: 'Notifications',
                        onTap: () {
                          Get.toNamed('/notificationPage');
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.file_download_outlined,
                        title: 'Downloads',
                        onTap: () {
                          Get.toNamed(AppRoute.getDownloadView());
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext,
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.workspace_premium_outlined,
                        title: isSubscribed
                            ? 'Manage Subscription'
                            : 'Upgrade to Premium',
                        isPremium: true,
                        leadingWidget: isSubscribed
                            ? Image.asset(
                                AppAssets.crown,
                                width: 20.w,
                                height: 20.h,
                                color: Colors.white,
                              )
                            : null,
                        onTap: () {
                          Get.toNamed(AppRoute.getSubscriptionView());
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext,
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.settings_outlined,
                        title: 'Account Settings',
                        onTap: () {
                          Get.toNamed('/accountSetting');
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {
                          Get.toNamed(AppRoute.getHelpAndSupportPage());
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.info_outline,
                        title: 'Terms & Conditions',
                        onTap: () {
                          Get.toNamed(AppRoute.getTermsAndConditionPage());
                        },
                      ),
                      Divider(
                        color: AppColors.primarytext.withOpacity(0.3),
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItem(
                        icon: Icons.exit_to_app,
                        title: 'Log Out',
                        isLogout: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.coreprimarydark,
                                title: Text(
                                  'Confirm Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  'Are you sure you want to log out?',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: AppColors.boxbreathingcolor2,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      loginController.logout();
                                    },
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
