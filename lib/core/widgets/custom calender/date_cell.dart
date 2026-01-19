import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
//import '../../core/theme/calendar_colors.dart';

class DateCell extends StatelessWidget {
  final int? day;
  final double itemWidth;
  final double visualSize;

  const DateCell({
    required this.day,
    required this.itemWidth,
    required this.visualSize,
    super.key,
  });

  static const fireDays = {15, 16, 17, 18, 19, 20, 21, 22};
  static const highlightDays = {1, 5, 9, 24, 26};

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return SizedBox(width: itemWidth, height: itemWidth);
    }

    final isFire = fireDays.contains(day);
    final isHighlight = highlightDays.contains(day);

    return SizedBox(
      width: itemWidth,
      height: itemWidth,
      child: Center(
        child: Container(
          width: visualSize,
          height: visualSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isFire || isHighlight
                ? CalendarColors.dateCircleYellow
                : CalendarColors.dateCircleWhite,
            shape: BoxShape.circle,
          ),
          child: Text(
            isFire ? '🔥' : '$day',
            style: TextStyle(
              fontSize: isFire ? visualSize * 0.65 : visualSize * 0.55,
              fontWeight: FontWeight.w600,
              color: CalendarColors.dateTextDark,
            ),
          ),
        ),
      ),
    );
  }
}
