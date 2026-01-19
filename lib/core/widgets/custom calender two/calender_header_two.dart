import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/calender_theme_two.dart';

class CalendarHeader extends StatelessWidget {
  final String title;
  final CalendarThemeTwo theme;

  const CalendarHeader({super.key, required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: theme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white.withOpacity(0.2),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }
}
