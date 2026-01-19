import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/reaction_widget.dart';
import 'package:zenzi/modules/home/controller/mood_controller.dart';
import 'package:zenzi/routes/app_routes.dart';
import 'package:zenzi/modules/notification/view/notification_view.dart';
import 'package:zenzi/core/theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final moodController = Get.put(MoodController());
    final int currentHour = DateTime.now().hour;
    final bool isDay = currentHour >= 6 && currentHour < 18;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black, // fallback (important)
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: isDay ? AppTheme.dayBackgroundColor : null,
                gradient: isDay ? null : AppTheme.nightGradient,
                image: DecorationImage(
                  image: AssetImage(
                    isDay ? AppAssets.homepage : AppAssets.homepageEvening,
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NotificationView(),
                            ),
                          );
                        },
                        child: _iconBox('assets/icons/home/notification.png'),
                      ),
                      _iconBox('assets/image/home/profile.png'),
                    ],
                  ),

                  SizedBox(height: 60.h),

                  Text(
                    'Good Morning',
                    style: AppTextStyle.h1.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    'Water does not forget its way\n-Yoruba Proverb',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h3.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.meditationPage);
                            },
                            child: Stack(
                              children: [
                                Image.asset(AppAssets.meditate),
                                Positioned(
                                  left: 30.w,
                                  right: 30.w,
                                  bottom: 40.h,
                                  child: Text(
                                    'Meditate',
                                    style: AppTextStyle.h2.copyWith(
                                      color: AppColors.primarytext,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Stack(
                            children: [
                              Image.asset(AppAssets.sleep),
                              Positioned(
                                left: 30.w,
                                right: 0,
                                bottom: 40.h,
                                child: Text(
                                  'Sleep',
                                  style: AppTextStyle.h2.copyWith(
                                    color: AppColors.primarytext,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.affirmationView);
                            },
                            child: Stack(
                              children: [
                                Image.asset(AppAssets.affirmation),
                                Positioned(
                                  left: 30.w,
                                  right: 30.w,
                                  bottom: 30.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Affirmations',
                                        style: AppTextStyle.h2.copyWith(
                                          color: AppColors.primarytext,
                                        ),
                                      ),
                                      Text(
                                        'Trust your journey',
                                        style: AppTextStyle.h5.copyWith(
                                          color: AppColors.primarytext,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.chatView);
                            },
                            child: Stack(
                              children: [
                                Image.asset(AppAssets.askzenzi),
                                Positioned(
                                  left: 30.w,
                                  right: 0,
                                  bottom: 40.h,
                                  child: Text(
                                    'Ask Zenzi',
                                    style: AppTextStyle.h2.copyWith(
                                      color: AppColors.primarytext,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'How are you feeling today?',
                                style: AppTextStyle.h7.copyWith(
                                  color: AppColors.primarytext,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  moodController.moods.length,
                                  (index) => MoodWidget(
                                    emoji:
                                        moodController.moods[index]['emoji']!,
                                    label:
                                        moodController.moods[index]['label']!,
                                    isSelected:
                                        moodController
                                            .selectedMoodIndex
                                            .value ==
                                        index,
                                    onTap: () {
                                      moodController.selectMood(index);
                                      debugPrint(
                                        'Home page - Selected mood: ${moodController.moods[index]['label']}',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Stack(
                  //   children: [
                  //     Image(image: Image.asset(AppAssets.meditate).image),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Positioned(
                  //         left: 0,
                  //         right: 0,
                  //         child: Text(
                  //           'Meditate',
                  //           style: AppTextStyle.h1.copyWith(
                  //             color: AppColors.primarytext,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //SizedBox(height: 6.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ICON BOX
  Widget _iconBox(String asset) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundcolor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.all(8.w),
      child: Image.asset(asset, width: 30.w, height: 30.h),
    );
  }
}
