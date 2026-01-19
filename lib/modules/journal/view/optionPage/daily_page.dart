import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/reaction_widget.dart';
import 'package:zenzi/modules/home/controller/mood_controller.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Separate controller instance for daily page - no conflict with home page
    final dailyMoodController = Get.put(MoodController(), tag: 'daily');
    final noteController = TextEditingController();

    return Column(
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'How are you feeling today?',
                  style: AppTextStyle.h7.copyWith(color: AppColors.primarytext),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    dailyMoodController.moods.length,
                    (index) => MoodWidget(
                      emoji: dailyMoodController.moods[index]['emoji']!,
                      label: dailyMoodController.moods[index]['label']!,
                      isSelected:
                          dailyMoodController.selectedMoodIndex.value == index,
                      onTap: () {
                        dailyMoodController.selectMood(index);
                        debugPrint(
                          'Daily page - Selected mood: ${dailyMoodController.moods[index]['label']}',
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Note Input Card - Exact UI from reference image
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.secondarycolor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add a note (optional)',
                      style: TextStyle(
                        color: AppColors.componentgreenish,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: noteController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.componentgreenish,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: const Color(0xFF8B7355),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: const Color(0xFF8B7355),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.secondarycolor,
                        contentPadding: EdgeInsets.all(12.w),
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Save Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: AppButton(
                title: 'Save Check-In',
                onTap: () {
                  final selectedMoodIndex =
                      dailyMoodController.selectedMoodIndex.value;
                  final note = noteController.text;

                  if (selectedMoodIndex != -1) {
                    final selectedMood =
                        dailyMoodController.moods[selectedMoodIndex]['label'];
                    debugPrint(
                      'Saving check-in: Mood=$selectedMood, Note=$note',
                    );
                  } else {
                    Get.snackbar('Error', 'Please select your mood first');
                  }
                },
                backgroundColor: AppColors.primarycolor,
              ),
            ),

            // MusicCardWidget(isFav: true),
            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
