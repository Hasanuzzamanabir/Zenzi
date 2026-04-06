import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/preference/controller/continue_button_controller.dart';
import 'package:zenzi/modules/preference/controller/progress_indicator_controller.dart';
import 'package:zenzi/modules/preference/controller/time_slot_controller.dart';
import 'package:zenzi/modules/preference/view/third_page.dart';
import 'package:zenzi/modules/preference/widgets/time_slot_card.dart';

class SecondPage extends StatelessWidget {
  //final controller = Get.find<TopicSelectionController>();
  final progressController = Get.find<ProgressIndicatorController>();
  final timeSlotController = Get.put(TimeSlotController());
  final buttonController = Get.find<ContinueButtonController>();

  SecondPage({super.key});

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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stay on Track',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'When would you like gentle reminders?',
              style: TextStyle(
                color: AppColors.secondarycolor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 48.h),
            Obx(
              () => Column(
                children: [
                  TimeSlotCard(
                    icon: Image.asset(
                      AppAssets.notifySun,
                      width: 24.r,
                      height: 24.r,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                    title: 'Morning',
                    time: '7:00 AM',
                    isSelected: timeSlotController.selectedIndex.value == 0,
                    onTap: () => timeSlotController.select(0),
                  ),
                  SizedBox(height: 16.h),
                  TimeSlotCard(
                    icon: Image.asset(
                      AppAssets.evening,

                      width: 24.r,
                      height: 24.r,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                    title: 'Evening',
                    time: '12:00 PM',

                    isSelected: timeSlotController.selectedIndex.value == 1,
                    onTap: () => timeSlotController.select(1),
                  ),
                ],
              ),
            ),

            SizedBox(height: 126.h),

            Obx(
              () => GestureDetector(
                onTap: buttonController.isEnabled
                    ? () {
                        progressController.nextStep();
                        Get.to(() => ThirdPage());
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
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Skip for now',
                style: TextStyle(
                  color: AppColors.secondarycolor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
