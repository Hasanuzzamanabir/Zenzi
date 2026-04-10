import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/breath_page/box_breathing/views/breathing_view.dart';

import 'package:zenzi/modules/breath_page/calm_breathing/views/breathing_view.dart';
import 'package:zenzi/modules/breath_page/energizing_breathing/views/energizing_breathing_view.dart';
import 'package:zenzi/modules/breath_page/controller/breathing_controller.dart';
import 'package:zenzi/modules/breath_page/four_seven_eight_brathing/views/breathing_view.dart';
import 'package:zenzi/modules/breath_page/model/breathing_model.dart';

class BreathPageView extends StatelessWidget {
  const BreathPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final BreathingController controller =
        Get.isRegistered<BreathingController>()
        ? Get.find<BreathingController>()
        : Get.put(BreathingController());
    return ThemedScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.h),
        child: AppBar(
          backgroundColor: const Color(0xFFCC8855),
          elevation: 0,
          automaticallyImplyLeading: false,

          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.appBarGradientColors,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Breathing Exercises",
                  style: AppTextStyle.h2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Calm your mind and body with\nintentional breath",
                  style: AppTextStyle.h3.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 32.h, left: 16.w, right: 16.w),
          children: [
            _infoCard(),
            SizedBox(height: 16.h),

            // Display breathing exercises from API
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : controller.breathingExercises.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Text(
                          'No breathing exercises available',
                          style: AppTextStyle.h6,
                        ),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        controller.breathingExercises.length,
                        (index) {
                          final exercise = controller.breathingExercises[index];
                          return exerciseCard(
                            title: exercise.title,
                            summary: exercise.summary,
                            inhaleSeconds: exercise.inhaleSeconds.toString(),
                            holdSeconds: exercise.holdSeconds.toString(),
                            exhaleSeconds: exercise.exhaleSeconds.toString(),
                            recommendedCycles: exercise.recommendedCycles
                                .toString(),
                            totalSession: exercise.totalSession.toString(),
                            icon: _resolveIconPath(exercise.iconCode),
                            onTap: () {
                              _navigateToBreathingView(exercise);
                            },
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(height: 20.h),
            _breathingTipsCard(),
            SizedBox(height: 20.h),
            _quoteCard(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Navigate to appropriate breathing view based on iconCode
  static void _navigateToBreathingView(BreathingModel exercise) {
    switch (exercise.iconCode.toUpperCase()) {
      case 'BOX':
        Get.to(
          () => BoxBreathingView(
            exerciseId: exercise.id,
            inhaleSeconds: exercise.inhaleSeconds,
            holdSeconds: exercise.holdSeconds,
            exhaleSeconds: exercise.exhaleSeconds,
            recommendedCycles: exercise.recommendedCycles,
            totalSession: exercise.totalSession,
          ),
        );
        break;

      case 'SLEEP':
        Get.to(
          () => FourSevenEightBreathingView(
            exerciseId: exercise.id,
            inhaleSeconds: exercise.inhaleSeconds,
            holdSeconds: exercise.holdSeconds,
            exhaleSeconds: exercise.exhaleSeconds,
            recommendedCycles: exercise.recommendedCycles,
            totalSession: exercise.totalSession,
          ),
        );
        break;
      case 'LIGHTNING':
        Get.to(
          () => CalmBreathingView(
            exerciseId: exercise.id,
            inhaleSeconds: exercise.inhaleSeconds,
            holdSeconds: exercise.holdSeconds,
            exhaleSeconds: exercise.exhaleSeconds,
            recommendedCycles: exercise.recommendedCycles,
            totalSession: exercise.totalSession,
          ),
        );
        break;
      case 'WIND':
        Get.to(
          () => EnergizingBreathingView(
            exerciseId: exercise.id,
            inhaleSeconds: exercise.inhaleSeconds,
            holdSeconds: exercise.holdSeconds,
            exhaleSeconds: exercise.exhaleSeconds,
            recommendedCycles: exercise.recommendedCycles,
            totalSession: exercise.totalSession,
          ),
        );
        break;
      default:
        Get.to(
          () => BoxBreathingView(
            exerciseId: exercise.id,
            inhaleSeconds: exercise.inhaleSeconds,
            holdSeconds: exercise.holdSeconds,
            exhaleSeconds: exercise.exhaleSeconds,
            recommendedCycles: exercise.recommendedCycles,
            totalSession: exercise.totalSession,
          ),
        );
    }
  }

  static String _resolveIconPath(String iconCode) {
    switch (iconCode.toUpperCase()) {
      case 'BOX':
        return AppAssets.box;
      case 'SLEEP':
        return AppAssets.fourb;
      case 'LIGHTNING':
        return AppAssets.calm;
      case 'WIND':
        return AppAssets.energy;
      default:
        return AppAssets.box;
    }
  }

  // ---------------- CARDS ----------------

  static Widget _infoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.coreprimarydark,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(
                  "assets/icons/bottom_nav_bar/pulmonology.png",
                ),
                color: Colors.white,
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: 8.w),
              Text(
                "Why practice breathing?",
                style: AppTextStyle.h7.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const Text(
            "Conscious breathing activates your body's natural relaxation response, reducing stress, lowering blood pressure, and bringing clarity to your mind.",
            style: AppTextStyle.h6,
          ),
        ],
      ),
    );
  }

  static Widget exerciseCard({
    required String title,
    required String summary,
    String? iconCode,
    required String inhaleSeconds,
    required String holdSeconds,
    required String exhaleSeconds,
    required String recommendedCycles,
    required String totalSession,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.componentnormal,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.cardborder, width: 1.11.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, width: 40.w, height: 40.h, fit: BoxFit.contain),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFF2F333D),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      summary,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: AppColors.cardtext,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 14.sp, color: Color(0xFF4A5366)),
              SizedBox(width: 2.w),
              Text(
                "$inhaleSeconds s",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF4A5366),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.pause, size: 14.sp, color: Color(0xFF4A5366)),
              SizedBox(width: 2.w),
              Text(
                "$holdSeconds s",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF4A5366),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.arrow_downward, size: 14.sp, color: Color(0xFF4A5366)),
              SizedBox(width: 2.w),
              Text(
                "$exhaleSeconds s",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF4A5366),

                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "$recommendedCycles cycles",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF4A5366),

                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundhorizon,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_outlined,
                      size: 20.sp,
                      color: AppColors.primarytext,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Start Exercise",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primarytext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _breathingTipsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.componentnormal,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.cardborder, width: 1.11.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "💡 Breathing Tips",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: Color(0xFF2D1810),
            ),
          ),
          SizedBox(height: 12.h),
          _TipItem(
            text: "Find a quiet and comfortable space",
            style: TextStyle(color: Color(0xFF5A3825), fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          _TipItem(
            text: "Sit or lie down in a relaxed posture",
            style: TextStyle(color: Color(0xFF5A3825), fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          _TipItem(
            text: "Breathe through your nose when possible",
            style: TextStyle(color: Color(0xFF5A3825), fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          _TipItem(
            text: "Don't force your breath; let it flow with ease",
            style: TextStyle(color: Color(0xFF5A3825), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  static Widget _quoteCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.quotecolor1, AppColors.quotecolor2],
        ),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        children: [
          Text(
            '"Breath is the bridge which connects life to \n consciousness."',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "— Ancient Wisdom",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const _TipItem({required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• ",
          style: TextStyle(
            color: Color(0xFF486B48),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Color(0xFF3E4555), fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
