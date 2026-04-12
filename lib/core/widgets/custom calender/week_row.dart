import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
import 'date_cell.dart';

class WeekRow extends StatelessWidget {
  final List<int?> weekDays;
  final Set<int> streakDays;

  const WeekRow({required this.weekDays, required this.streakDays, super.key});

  @override
  Widget build(BuildContext context) {
    final streakIndices = <int>[];
    for (int i = 0; i < weekDays.length; i++) {
      if (weekDays[i] != null && streakDays.contains(weekDays[i])) {
        streakIndices.add(i);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / 7;
        final visualSize = itemWidth * 0.7;

        return SizedBox(
          height: itemWidth,
          child: Stack(
            children: [
              if (streakIndices.isNotEmpty)
                ..._buildFireStreaks(streakIndices, itemWidth, visualSize),

              Row(
                children: weekDays
                    .map(
                      (day) => DateCell(
                        day: day,
                        isStreakDay: day != null && streakDays.contains(day),
                        itemWidth: itemWidth,
                        visualSize: visualSize,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildFireStreaks(
    List<int> streakIndices,
    double itemWidth,
    double visualSize,
  ) {
    final ranges = <List<int>>[];
    List<int> current = [];

    for (final i in streakIndices) {
      if (current.isEmpty || i == current.last + 1) {
        current.add(i);
      } else {
        ranges.add(current);
        current = [i];
      }
    }
    if (current.isNotEmpty) ranges.add(current);

    return ranges.map((range) {
      final sidePadding = (itemWidth - visualSize) / 2;
      final left = range.first * itemWidth + sidePadding;
      final right = range.last * itemWidth + itemWidth - sidePadding;
      final expansion = 6.w;

      return Positioned(
        left: left - expansion,
        top: (itemWidth - visualSize) / 2 - expansion,
        width: (right - left) + expansion * 2,
        height: visualSize + expansion * 2,
        child: Container(
          decoration: BoxDecoration(
            color: CalendarColors.fireStreakBg,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      );
    }).toList();
  }
}
