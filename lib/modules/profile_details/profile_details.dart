// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';
import 'package:zenzi/modules/setting/widgets/build_menu_item.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
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
    final int currentHour = DateTime.now().hour;
    final bool isDay = currentHour >= 6 && currentHour < 18;

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundhorizon,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.componentnormal,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            final profile = editProfileController.profile.value;
                            final avatarUrl = resolveAvatarUrl(
                              profile?.avatarUrl,
                            );
                            return CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: avatarUrl != null
                                  ? NetworkImage(avatarUrl)
                                  : AssetImage(AppAssets.profile)
                                        as ImageProvider,
                            );
                          }),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isDay ? 'Good Morning' : 'Good Evening',
                                  style: TextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Obx(() {
                                  final profile =
                                      editProfileController.profile.value;
                                  return Text(
                                    profile?.name ?? 'Steven Smith',
                                    style: TextStyle(
                                      color: AppColors.primarytext,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundcolor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No matter how long the night, the\ndawn will break',
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 16.sp,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '— African Proverb',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                BuildMenuItem(
                  title: 'Edit Profile',
                  onTap: () {
                    Get.toNamed('/editProfile');
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
