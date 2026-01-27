import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class CalendarThemeTwo {
  final Color background;
  final Color border;
  final Color textWhite;
  final Color weekdayText;
  final Color dateText;

  const CalendarThemeTwo({
    this.background = AppColors.coreprimarydark,
    this.border = AppColors.componentnormal,
    this.textWhite = Colors.white,
    this.weekdayText = const Color(0xFFFAEBD7),
    this.dateText = const Color(0xFF484848),
  });
}
