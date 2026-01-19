import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/preference/controller/continue_button_controller.dart';
import 'package:zenzi/modules/preference/controller/progress_indicator_controller.dart';
import 'package:zenzi/modules/preference/controller/topic_selection_controller.dart';
import 'package:zenzi/modules/preference/view/second_page.dart';

class PreferencePage extends StatelessWidget {
  final controller = Get.find<TopicSelectionController>();
  final progressController = Get.find<ProgressIndicatorController>();
  final buttonController = Get.find<ContinueButtonController>();

  PreferencePage({super.key});

  static const List<String> images = [
    AppAssets.rStress,
    AppAssets.iFocus,
    AppAssets.rAnxiety,
    AppAssets.happiness,
    AppAssets.pGrowth,
    AppAssets.bSleep,
    AppAssets.eHealing,
  ];

  static List<double> heights = [
    220.h,
    180.h,
    220.h,
    180.h,
    180.h,
    220.h,
    220.h,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A3A22),
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
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              AppAssets.preferenceFirst,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'What Brings You\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'to Zenzi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Select topic to focuses on: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      itemCount: images.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final isSelected = controller.selectedIndexes
                              .contains(index);

                          return GestureDetector(
                            onTap: () => controller.toggleSelection(index),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                if (isSelected)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(80),
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          8.0,
                                        ), // Optional: add some space from the edge
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                    SizedBox(height: 28.h),

                    Obx(
                      () => GestureDetector(
                        onTap: buttonController.isEnabled
                            ? () {
                                progressController.nextStep();
                                Get.to(() => SecondPage());
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
                                  "Continue",
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
