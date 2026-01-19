import 'package:flutter/material.dart';

class CalendarThemeTwo {
  final Color background;
  final Color border;
  final Color textWhite;
  final Color weekdayText;
  final Color dateText;

  const CalendarThemeTwo({
    this.background = const Color(0xFF965A2E),
    this.border = const Color(0xFFC89B65),
    this.textWhite = Colors.white,
    this.weekdayText = const Color(0xFFFAEBD7),
    this.dateText = const Color(0xFF4A3B2A),
  });
}
