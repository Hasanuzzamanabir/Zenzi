import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
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

  // Morning → warm brown day color
  // Evening → deep night purple color
  Color get _bgColor => timeSlotController.selectedIndex.value == 0
      ? AppColors
            .backgroundcolor // Morning
      : const Color(0xFF1D1249); // Evening

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: _bgColor,
        appBar: AppBar(
          backgroundColor: _bgColor,
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
                  children: List.generate(progressController.totalSteps, (
                    index,
                  ) {
                    final isActive =
                        index < progressController.currentStep.value;
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
                () => AppButton(
                  isLoading: timeSlotController.isLoading.value,
                  title: "Contine",
                  onTap: () async {
                    final result = await timeSlotController.setReminderTime();
                    if (result) {
                      progressController.nextStep();
                      Get.to(() => ThirdPage());
                    }
                  },
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
      ),
    );
  }
}
