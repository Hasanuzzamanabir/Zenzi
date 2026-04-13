// ignore_for_file: dead_code, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/affirmation/view/affirmationview.dart';
import 'package:zenzi/modules/auth/view/login/controller/login_controller.dart';
import 'package:zenzi/modules/favourite/controller/favourite_affirm_controller.dart';
import 'package:zenzi/modules/journal/controller/journal_controller.dart';
import 'package:zenzi/modules/more/controller/view_status_achievements_controllder.dart';
import 'package:zenzi/modules/more/widget/build_favourite.dart';
import 'package:zenzi/modules/more/widget/builds_state_item.dart';
import 'package:zenzi/modules/more/widget/seeting_item.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';
import 'package:zenzi/modules/subscription/view/premium_subscription.dart';
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

  final favouriteCountController = Get.put(FavouriteAffirmController());
  final journalController = Get.put(JournalController());

  final ViewStatusAchievementsControllder viewStatusAchievementsControllder =
      Get.put(ViewStatusAchievementsControllder());

  @override
  void initState() {
    super.initState();
    editProfileController.fetchProfile();
    journalController.fetchJournalEntries();
  }

  String? resolveAvatarUrl(String? url) {
    if (url == null || url.trim().isEmpty) return null;

    final uri = Uri.tryParse(url);
    return (uri != null && uri.hasScheme)
        ? url
        : '${BaseUrl.baseUrl}/${url.replaceFirst(RegExp(r'^/+'), '')}';
  }

  Widget _buildMoodDot(Color color, String day) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(height: 4.h),
        Text(
          day,
          style: TextStyle(
            color: AppColors.secondarycolor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Color _moodColor(String? mood) {
    switch (mood?.trim().toUpperCase()) {
      case 'GREAT':
        return Colors.green;
      case 'GOOD':
        return Colors.lightGreen;
      case 'OKAY':
        return Colors.yellow;
      case 'LOW':
        return Colors.orange;
      case 'ANXIOUS':
        return Colors.red.shade400;
      default:
        return Colors.white;
    }
  }

  String _weekdayShort(int weekday) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return labels[weekday - 1];
  }

  String _normalizeDateKey(String rawDate) {
    if (rawDate.length >= 10) {
      return rawDate.substring(0, 10);
    }
    return rawDate;
  }

  List<Widget> _buildLast7DayMoodDots() {
    final latestEntryByDate = <String, dynamic>{};
    for (final entry in journalController.journalEntries) {
      final dateKey = _normalizeDateKey(entry.date);
      final existing = latestEntryByDate[dateKey];

      if (existing == null || entry.id > existing.id) {
        latestEntryByDate[dateKey] = entry;
      }
    }

    final today = DateTime.now();
    return List.generate(7, (index) {
      final day = today.subtract(Duration(days: 6 - index));
      final dateKey =
          '${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      final mood = latestEntryByDate[dateKey]?.mood as String?;

      return _buildMoodDot(_moodColor(mood), _weekdayShort(day.weekday));
    });
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
                // Unlock Premium Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.premiumcardcolor1,
                        AppColors.premiumcardcolor2,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppAssets.crown, width: 24.w, height: 24.h),
                      SizedBox(height: 8.h),
                      Text(
                        'Unlock Premium',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Get unlimited access to all\nmeditations, sleep stories, and\nexclusive content',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.sp,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const PremiumSubscriptionView());
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explore Premium',
                                style: TextStyle(
                                  color: AppColors.premiumbuttontext1,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Stats & Achievements Card
                Obx(() {
                  final controller =
                      viewStatusAchievementsControllder.achievement.value;
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundhorizon,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.cardborder, width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StatItem(
                              value: controller?.currentSteak.toString() ?? '0',
                              label: 'Streak',
                              image: Image.asset(
                                AppAssets.vector5,
                                width: 24.w,
                                height: 24.h,
                              ),
                              textColor: AppColors.digitcolor,
                            ),
                            StatItem(
                              value:
                                  controller?.totalSessions.toString() ?? '0',
                              label: 'Sessions',
                              image: Image.asset(
                                AppAssets.icon5,
                                width: 24.w,
                                height: 24.h,
                              ),
                              textColor: AppColors.boxbreathingcolor1,
                            ),
                            StatItem(
                              value: controller?.totalMinutes.toString() ?? '0',
                              label: 'Minutes',
                              image: Image.asset(
                                AppAssets.icon6,
                                width: 24.w,
                                height: 24.h,
                              ),
                              textColor: AppColors.digitcolor2,
                            ),
                            StatItem(
                              value:
                                  controller?.currentLevel.toString() ??
                                  'Grounded',
                              label: 'Level',
                              image: Image.asset(
                                AppAssets.icon7,
                                width: 24.w,
                                height: 24.h,
                              ),
                              textColor: Color(0xFFFF9C2A),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoute.getStatisticAndAchivementPage(),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.primarycolor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'View Full Stats & Achievements',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 16.h),

                // Quote Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.quoteCard),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"If you want to go fast, go alone.If \n you want to go far, go together."',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '— African Proverb',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const AffirmationView());
                          },
                          child: Text(
                            'View More',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Your Mood Tracker
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primarycolor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.secondarycolor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Mood Over Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundhorizon,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Track your mood daily to see patterns',
                          style: TextStyle(
                            color: AppColors.secondarycolor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildLast7DayMoodDots(),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.journalView);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'View details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Saved Favorites
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundhorizon,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        final count =
                            favouriteCountController.favouriteCount.length;

                        return Row(
                          children: [
                            Text('Saved Favorites', style: AppTextStyle.h7),
                            Spacer(),
                            Text(
                              '$count items',
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.secondarycolor,
                              ),
                            ),
                          ],
                        );
                      }),

                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: FavoriteCard(
                              image: Image.asset(
                                AppAssets.saved1,
                                width: 39.w,
                                height: 39.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: FavoriteCard(
                              image: Image.asset(
                                AppAssets.saved2,
                                width: 33.w,
                                height: 33.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: FavoriteCard(
                              image: Image.asset(
                                AppAssets.saved3,
                                width: 33.w,
                                height: 33.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoute.getFavouritePageView());
                          },
                          child: Text(
                            'View all favorites',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

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
