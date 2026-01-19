import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/download/widgets/download_lesson_card.dart';

class DownloadLessonPage extends StatelessWidget {
  const DownloadLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DownloadLessonCard(
          id: 'lesson_1',
          title: 'Emotional Release',
          subtitle: 'Basics of Yoga for Beginners',
          duration: '30 min',
          backgroundColor: AppColors.backgroundhorizon,
          onPlay: () {
            debugPrint('Play lesson 1');
          },
          onDelete: () {
            debugPrint('Delete lesson 1');
          },
        ),
        SizedBox(height: 20.h),
        DownloadLessonCard(
          id: 'lesson_1',
          title: 'Emotional Release',
          subtitle: 'Basics of Yoga for Beginners',
          duration: '30 min',
          backgroundColor: AppColors.backgroundhorizon,
          onPlay: () {
            debugPrint('Play lesson 1');
          },
          onDelete: () {
            debugPrint('Delete lesson 1');
          },
        ),
        SizedBox(height: 20.h),
        DownloadLessonCard(
          id: 'lesson_1',
          title: 'Emotional Release',
          subtitle: 'Basics of Yoga for Beginners',
          duration: '30 min',
          backgroundColor: AppColors.backgroundhorizon,
          onPlay: () {
            debugPrint('Play lesson 1');
          },
          onDelete: () {
            debugPrint('Delete lesson 1');
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
