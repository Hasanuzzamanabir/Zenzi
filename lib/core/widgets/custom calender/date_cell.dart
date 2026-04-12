import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
//import '../../core/theme/calendar_colors.dart';

class DateCell extends StatelessWidget {
  final int? day;
  final bool isStreakDay;
  final double itemWidth;
  final double visualSize;

  const DateCell({
    required this.day,
    required this.isStreakDay,
    required this.itemWidth,
    required this.visualSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return SizedBox(width: itemWidth, height: itemWidth);
    }

    return SizedBox(
      width: itemWidth,
      height: itemWidth,
      child: Center(
        child: Container(
          width: visualSize,
          height: visualSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isStreakDay
                ? CalendarColors.dateCircleYellow
                : CalendarColors.dateCircleWhite,
            shape: BoxShape.circle,
          ),
          child: Text(
            isStreakDay ? '🔥' : '$day',
            style: TextStyle(
              fontSize: isStreakDay ? visualSize * 0.65 : visualSize * 0.55,
              fontWeight: FontWeight.w600,
              color: CalendarColors.dateTextDark,
            ),
          ),
        ),
      ),
    );
  }
}
