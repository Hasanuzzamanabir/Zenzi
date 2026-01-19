import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
//import '../../core/theme/calendar_colors.dart';
import 'weekday_label.dart';
import 'week_row.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int?> days = List.generate(35, (index) {
      if (index < 2) return null;
      final day = index - 1;
      if (day > 31) return null;
      return day;
    });

    final weeks = <List<int?>>[];
    for (int i = 0; i < days.length; i += 7) {
      weeks.add(days.sublist(i, i + 7));
    }

    return Container(
      width: 340.w,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: CalendarColors.backgroundBrown,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: CalendarColors.borderGold, width: 1.5.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'JAN 2025',
            style: TextStyle(
              color: CalendarColors.textWhite,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withOpacity(0.3), thickness: 1.h),
          SizedBox(height: 16.h),

          /// Weekdays
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              WeekdayLabel('MON'),
              WeekdayLabel('TUE'),
              WeekdayLabel('WED'),
              WeekdayLabel('THU'),
              WeekdayLabel('FRI'),
              WeekdayLabel('SAT'),
              WeekdayLabel('SUN'),
            ],
          ),
          SizedBox(height: 12.h),

          /// Weeks
          ...weeks.map((week) => WeekRow(weekDays: week)),
        ],
      ),
    );
  }
}
