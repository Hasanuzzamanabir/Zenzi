import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/meditation_view/controller/progressbar_controller.dart';

class CompletionBottomSheetContent extends StatelessWidget {
  const CompletionBottomSheetContent({
    super.key,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimaryPressed,
    required this.sheetContext,
  });

  final String title;
  final String description;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimaryPressed;
  final BuildContext sheetContext;

  void _closeSheet() {
    Navigator.of(sheetContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<ProgressbarController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC8893C), Color(0xFF8B5A2B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Close button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _closeSheet,
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),

          SizedBox(height: 8.h),

          /// Title
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 6.h),

          /// Description
          Text(
            description,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          /// Image (replace with your asset)
          Image.asset(
            AppAssets.simplification,
            height: 120.h,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 20.h),

          /// Points
          Obx(
            () {
              final int earned = progressController.pointsEarned.value;
              final int total = progressController.totalPoints.value;
              final String pointsLabel = earned > 0
                  ? "You got $earned Points"
                  : "Your total points: $total";

              return Text(
                pointsLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),

          SizedBox(height: 12.h),

          /// Progress text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Next level progress",
                style: TextStyle(color: Colors.white70, fontSize: 12.sp),
              ),
              Obx(
                () => Text(
                  "${progressController.progressToNextLevel.value}/${progressController.nextLevelThreshold.value}",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// Progress bar
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: progressController.nextLevelThreshold.value <= 0
                  ? 0
                  : (progressController.totalPoints.value /
                        progressController.nextLevelThreshold.value)
                      .clamp(0.0, 1.0),
                minHeight: 6.h,
                backgroundColor: Colors.black,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFC68A47),
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          /// Next Button (Primary style)
          SafeArea(
            child: SizedBox(
              // width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.congratsscrennbuttonclr,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(secondaryLabel, style: TextStyle(fontSize: 14.sp)),
                    SizedBox(width: 8.w),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
