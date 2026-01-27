import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/journal/widgets/note_card.dart';

import 'package:zenzi/core/widgets/custom calender two/custom_calender_two.dart';
import 'package:zenzi/modules/journal/widgets/mood_legend_row.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Explicit mood mapping for selected days (remaining days will be white)
    final Map<int, String> moodByDay = {
      1: 'Great',
      3: 'Good',
      4: 'Great',
      6: 'Good',
      8: 'Okay',
      9: 'Anxious',
      11: 'Okay',
      12: 'Anxious',
      15: 'Okay',
      16: 'Anxious',
      18: 'Okay',
      20: 'Anxious',
      21: 'Low',
      22: 'Anxious',
      24: 'Low',
      25: 'Anxious',
      27: 'Low',
      28: 'Anxious',
      30: 'Low',
      31: 'Anxious',
    };

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 20.h),
            CustomCalendarTwo(
              title: 'JAN 2025',
              daysGrid: const [
                [null, null, 1, 2, 3, 4, 5],
                [6, 7, 8, 9, 10, 11, 12],
                [13, 14, 15, 16, 17, 18, 19],
                [20, 21, 22, 23, 24, 25, 26],
                [27, 28, 29, 30, 31, null, null],
              ],
              dayColorBuilder: (day) {
                final mood = moodByDay[day];
                // If day is not present in moodByDay → return white color
                if (mood == null) return Colors.white;

                switch (mood) {
                  case 'Great':
                    return MoodLegendRow.greatColor;
                  case 'Good':
                    return MoodLegendRow.goodColor;
                  case 'Okay':
                    return MoodLegendRow.okayColor;
                  case 'Low':
                    return MoodLegendRow.lowColor;
                  case 'Anxious':
                    return MoodLegendRow.anxiousColor;
                  default:
                    return Colors.white;
                }
              },
            ),
            SizedBox(height: 20.h),
            const MoodLegendRow(),
            // Previous Note Title
            SizedBox(height: 30.h),
            Text(
              'Previous Note',
              style: AppTextStyle.h6.copyWith(color: AppColors.primarytext),
            ),
            SizedBox(height: 16.h),
            // Note Cards
            NoteCard(
              date: '12/12/25',
              title: 'Feeling felt heavy.',
              description:
                  'Not sure why, but my mind was all over the place. I tried to stay calm, but everything is a bit of draining.',
            ),
            NoteCard(
              date: '12/12/25',
              title: 'Feeling a little disconnected.',
              description:
                  'Lots of work, and I realized, just low energy. Maybe tomorrow will be better.',
            ),
            NoteCard(
              date: '12/12/25',
              title: 'Not physically — just mentally, I think.',
              description:
                  'I needed a break but couldn'
                  'll try to rest more this weekend.',
            ),
            NoteCard(
              date: '12/12/25',
              title: 'Today was surprisingly good.',
              description:
                  'Things just clicked, and I felt content. Not actually felt present. Loved that feeling.',
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
