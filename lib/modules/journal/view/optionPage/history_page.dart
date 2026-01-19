import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/journal/widgets/note_card.dart';

import 'package:zenzi/core/widgets/custom calender two/custom_calender_two.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                if ([1, 2, 3].contains(day)) return const Color(0xFF6BBE76);
                if ([5, 9, 15, 16, 17, 18, 19, 20].contains(day)) {
                  return const Color(0xFFC0CA33);
                }
                if ((day >= 10 && day <= 13) || (day >= 21 && day <= 27)) {
                  return const Color(0xFFF57C20);
                }
                return const Color(0xFFEEEEEE);
              },
            ),
            // Previous Note Title
            SizedBox(height: 20.h),
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
