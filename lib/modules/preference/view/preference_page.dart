import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/preference/controller/continue_button_controller.dart';
import 'package:zenzi/modules/preference/controller/progress_indicator_controller.dart';
import 'package:zenzi/modules/preference/controller/topic_selection_controller.dart';
import 'package:zenzi/modules/preference/model/preference_step_one_model.dart';
import 'package:zenzi/modules/preference/view/second_page.dart';

class PreferencePage extends StatelessWidget {
  final controller = Get.find<TopicSelectionController>();
  final progressController = Get.find<ProgressIndicatorController>();
  final buttonController = Get.find<ContinueButtonController>();

  PreferencePage({super.key});

  static List<PreferenceStepOneModel> images = [
    PreferenceStepOneModel(
      id: 1,
      image: AppAssets.rStress,
      topicCode: 'Reduce Stress',
    ),
    PreferenceStepOneModel(
      id: 2,
      image: AppAssets.iFocus,
      topicCode: 'Improve Focus',
    ),
    PreferenceStepOneModel(
      id: 3,
      image: AppAssets.rAnxiety,
      topicCode: 'Increase Happiness',
    ),
    PreferenceStepOneModel(
      id: 4,
      image: AppAssets.happiness,
      topicCode: 'Reduce Anxiety',
    ),
    PreferenceStepOneModel(
      id: 5,
      image: AppAssets.pGrowth,
      topicCode: 'Better Sleep',
    ),
    PreferenceStepOneModel(
      id: 6,
      image: AppAssets.bSleep,
      topicCode: 'Personal Growth',
    ),
    PreferenceStepOneModel(
      id: 7,
      image: AppAssets.eHealing,
      topicCode: 'Emotional Healing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                            onTap: () {
                              log(
                                'Tapped on index: ${images[index].topicCode}, $index',
                              );
                              controller.toggleSelection(index);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    images[index].image,
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
                        onTap:
                            buttonController.isEnabled &&
                                !controller.isSubmitting.value
                            ? () async {
                                final saved = await controller.selectedTopics(
                                  images,
                                );
                                if (saved) {
                                  progressController.nextStep();
                                  Get.to(() => SecondPage());
                                }
                              }
                            : null,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color:
                                buttonController.isEnabled &&
                                    !controller.isSubmitting.value
                                ? AppColors.primarycolor
                                : Colors.grey,
                          ),
                          child: Center(
                            child: controller.isSubmitting.value
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Continue',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
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
