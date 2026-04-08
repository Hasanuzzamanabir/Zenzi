import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/auth/view/login/controller/login_controller.dart';
import 'package:zenzi/modules/more/widget/builds_state_item.dart';
import 'package:zenzi/modules/more/widget/build_favourite.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';
import 'package:zenzi/modules/subscription/view/premium_subscription.dart';
import 'package:zenzi/routes/app_routes.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
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
      final int currentHour = DateTime.now().hour;
    final bool isDay = currentHour >= 6 && currentHour < 18;
    return ThemedScaffold(
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
                          color: Colors.white.withOpacity(0.9),
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
                Container(
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
                            value: '7',
                            label: 'Streak',
                            image: Image.asset(
                              AppAssets.vector5,
                              width: 24.w,
                              height: 24.h,
                            ),
                            textColor: AppColors.digitcolor,
                          ),
                          StatItem(
                            value: '42',
                            label: 'Sessions',
                            image: Image.asset(
                              AppAssets.icon5,
                              width: 24.w,
                              height: 24.h,
                            ),
                            textColor: AppColors.boxbreathingcolor1,
                          ),
                          StatItem(
                            value: '320',
                            label: 'Minutes',
                            image: Image.asset(
                              AppAssets.icon6,
                              width: 24.w,
                              height: 24.h,
                            ),
                            // textColor: AppColors.boxbreathingcolor1,
                            textColor: AppColors.digitcolor2,
                          ),
                          StatItem(
                            value: 'Grounded',
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
                          Get.toNamed(AppRoute.getStatisticAndAchivementPage());
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
                ),
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
                        child: Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMoodDot(Colors.green, 'M'),
                          _buildMoodDot(Colors.green, 'T'),
                          _buildMoodDot(Colors.yellow, 'W'),
                          _buildMoodDot(Colors.orange, 'T'),
                          _buildMoodDot(Colors.red.shade400, 'F'),
                          _buildMoodDot(Colors.white, 'S'),
                          _buildMoodDot(Colors.white, 'S'),
                        ],
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
                      Row(
                        children: [
                          Text('Saved Favorites', style: AppTextStyle.h7),
                          Spacer(),
                          Text(
                            '12 items',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.secondarycolor,
                            ),
                          ),
                        ],
                      ),

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
              ],
            ),
          ),
        ),
      ),
    );
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
}
