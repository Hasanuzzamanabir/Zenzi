import 'package:flutter/material.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/calender_header_two.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/calender_theme_two.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/date_cell_two.dart';
import 'package:zenzi/core/widgets/custom%20calender%20two/weekly_row_two.dart';

class CustomCalendarTwo extends StatelessWidget {
  final String title;
  final List<List<int?>> daysGrid;
  final Color Function(int day) dayColorBuilder;
  final CalendarThemeTwo theme;

  const CustomCalendarTwo({
    super.key,
    required this.title,
    required this.daysGrid,
    required this.dayColorBuilder,
    this.theme = const CalendarThemeTwo(),
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final safeWidth = constraints.maxWidth.isInfinite
              ? MediaQuery.of(context).size.width
              : constraints.maxWidth;

          const horizontalPadding = 16.0;
          const borderWidth = 1.5;

          final gridWidth =
              safeWidth - (horizontalPadding * 2) - (borderWidth * 2);

          final cellWidth = gridWidth / 7;
          final circleSize = cellWidth * 0.6;
          final fontSize = circleSize * 0.45;
          final weekdayFontSize = (cellWidth * 0.25).clamp(10.0, 14.0);

          return Container(
            width: safeWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.border, width: borderWidth),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CalendarHeader(title: title, theme: theme),
                const SizedBox(height: 16),
                WeekdayRow(fontSize: weekdayFontSize, theme: theme),
                const SizedBox(height: 12),

                /// Calendar grid
                ...daysGrid.map(
                  (week) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: week.map((day) {
                        return Expanded(
                          child: SizedBox(
                            height: cellWidth,
                            child: Center(
                              child: DateCellTwo(
                                day: day,
                                size: circleSize,
                                fontSize: fontSize,
                                backgroundColor: day == null
                                    ? null
                                    : dayColorBuilder(day),
                                theme: theme,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
