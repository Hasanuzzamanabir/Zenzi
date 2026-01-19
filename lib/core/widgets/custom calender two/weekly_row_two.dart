import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/calender_theme_two.dart';

class WeekdayRow extends StatelessWidget {
  final double fontSize;
  final CalendarThemeTwo theme;

  const WeekdayRow({super.key, required this.fontSize, required this.theme});

  @override
  Widget build(BuildContext context) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return Row(
      children: days
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    color: theme.weekdayText,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
