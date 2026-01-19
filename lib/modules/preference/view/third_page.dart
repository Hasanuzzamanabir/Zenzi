import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/bottom_navigation_bar/view/custom_buttom_navigation_bar.dart';
import 'package:zenzi/modules/preference/controller/continue_button_controller.dart';
import 'package:zenzi/modules/preference/controller/progress_indicator_controller.dart';
import 'package:zenzi/modules/preference/controller/time_slot_controller.dart';
import 'package:zenzi/modules/preference/controller/topic_selection_controller.dart';

class ThirdPage extends StatelessWidget {
  final controller = Get.find<TopicSelectionController>();
  final progressController = Get.find<ProgressIndicatorController>();
  final timeSlotController = Get.put(TimeSlotController());
  final buttonController = Get.find<ContinueButtonController>();

  ThirdPage({super.key});
  static const List<String> images = [
    AppAssets.guiding,
    AppAssets.sleep2,
    // AppAssets.iFocus,
    AppAssets.focus,
    AppAssets.breathpractise,
    //AppAssets.happiness,
    AppAssets.daily,
    //AppAssets.bSleep,
    AppAssets.counselling,
  ];

  static List<double> heights = [
    200.h,
    200.h,
    200.h,
    200.h,
    200.h,
    200.h,
    200.h,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondarycolor),
          onPressed: () {
            progressController.previousStep();
            Get.back();
          },
        ),
        title: Obx(
          () => Text(
            'Step ${progressController.currentStep.value} of ${progressController.totalSteps}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Obx(
              () => Row(
                children: List.generate(progressController.totalSteps, (index) {
                  final isActive = index < progressController.currentStep.value;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 20.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primarycolor
                          : AppColors.whitelite,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppAssets.onboarding, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your wellness journey',
                    style: TextStyle(
                      color: AppColors.primarytext,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Everything you need in one place',
                    style: TextStyle(
                      color: AppColors.secondarycolor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 10,
                    itemCount: images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected = controller.selectedIndexes.contains(
                          index,
                        );

                        return GestureDetector(
                          onTap: () => controller.toggleSelection(index),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.contain,
                                  height: heights[index],
                                ),
                              ),
                              // if (isSelected)
                              //   Positioned.fill(
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.black.withAlpha(80),
                              //         borderRadius: BorderRadius.circular(16.r),
                              //       ),
                              //       alignment: Alignment.topRight,
                              //       child: Padding(
                              //         padding: EdgeInsets.all(
                              //           8.0,
                              //         ), // Optional: add some space from the edge
                              //         child: const Icon(
                              //           Icons.check_circle,
                              //           color: Colors.white,
                              //           size: 40,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        );
                      });
                    },
                  ),
                  // SizedBox(height: 28.h),
                  Container(
                    width: double.maxFinite,

                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.quoteFrame),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        left: 12.0,
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '"If you want to go fast, go alone. If you want to go far, go together."',
                              style: TextStyle(
                                color: AppColors.skysunrise,
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
                                  color: AppColors.skysunrise,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Obx(
                    () => GestureDetector(
                      onTap: buttonController.isEnabled
                          ? () {
                              progressController.nextStep();
                              Get.to(() => CustomButtomNavigationBar());
                            }
                          : null,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: buttonController.isEnabled
                              ? AppColors.primarycolor
                              : Colors.grey,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start My Journey",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
