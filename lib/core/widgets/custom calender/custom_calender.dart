import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
//import '../../core/theme/calendar_colors.dart';
import 'weekday_label.dart';
import 'week_row.dart';

class CustomCalendar extends StatelessWidget {
  final List<DateTime> streakDates;
  final DateTime? visibleMonth;

  const CustomCalendar({
    super.key,
    this.streakDates = const [],
    this.visibleMonth,
  });

  @override
  Widget build(BuildContext context) {
    final month = visibleMonth ?? DateTime.now();
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingEmptyCells = firstDayOfMonth.weekday - 1;
    final totalCells = ((leadingEmptyCells + daysInMonth + 6) ~/ 7) * 7;

    final List<int?> days = List.generate(totalCells, (index) {
      final day = index - leadingEmptyCells + 1;
      if (day < 1 || day > daysInMonth) {
        return null;
      }
      return day;
    });

    final streakDaysInMonth = streakDates
        .where((date) => date.year == month.year && date.month == month.month)
        .map((date) => date.day)
        .toSet();

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
        border: Border.all(color: CalendarColors.borderGold, width: 1.0.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatMonthYear(month),
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
          ...weeks.map(
            (week) => WeekRow(weekDays: week, streakDays: streakDaysInMonth),
          ),
        ],
      ),
    );
  }

  String _formatMonthYear(DateTime date) {
    const monthNames = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return '${monthNames[date.month - 1]} ${date.year}';
  }
}
