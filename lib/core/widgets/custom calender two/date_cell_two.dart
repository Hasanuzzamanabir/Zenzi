import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/calender_theme_two.dart';

class DateCellTwo extends StatelessWidget {
  final int? day;
  final double size;
  final double fontSize;
  final Color? backgroundColor;
  final CalendarThemeTwo theme;

  const DateCellTwo({
    super.key,
    required this.day,
    required this.size,
    required this.fontSize,
    this.backgroundColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return SizedBox(width: size, height: size);
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$day',
        style: TextStyle(
          color: theme.dateText,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
