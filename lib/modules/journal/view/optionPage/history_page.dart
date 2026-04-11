import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/journal/controller/journal_controller.dart';
import 'package:zenzi/modules/journal/widgets/note_card.dart';

import 'package:zenzi/core/widgets/custom calender two/custom_calender_two.dart';
import 'package:zenzi/modules/journal/widgets/mood_legend_row.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month, 1);
  }

  void _changeMonth(int monthDelta) {
    setState(() {
      _visibleMonth = DateTime(
        _visibleMonth.year,
        _visibleMonth.month + monthDelta,
        1,
      );
    });
  }

  List<List<int?>> _buildDaysGrid(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final totalDaysInMonth = DateTime(month.year, month.month + 1, 0).day;

    final leadingEmptyCells = firstDayOfMonth.weekday - 1;
    final cells = <int?>[
      ...List<int?>.filled(leadingEmptyCells, null),
      ...List<int?>.generate(totalDaysInMonth, (index) => index + 1),
    ];

    final trailingEmptyCells = (7 - (cells.length % 7)) % 7;
    cells.addAll(List<int?>.filled(trailingEmptyCells, null));

    final grid = <List<int?>>[];
    for (int i = 0; i < cells.length; i += 7) {
      grid.add(cells.sublist(i, i + 7));
    }
    return grid;
  }

  String _dateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Color _colorFromMood(String mood) {
    switch (mood.toUpperCase()) {
      case 'GREAT':
        return MoodLegendRow.greatColor;
      case 'GOOD':
        return MoodLegendRow.goodColor;
      case 'OKAY':
        return MoodLegendRow.okayColor;
      case 'LOW':
        return MoodLegendRow.lowColor;
      case 'ANXIOUS':
        return MoodLegendRow.anxiousColor;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JournalController());
    final monthTitle = DateFormat('MMMM yyyy').format(_visibleMonth);
    final monthGrid = _buildDaysGrid(_visibleMonth);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Obx(() {
          final moodByDate = <String, String>{};
          for (final entry in controller.journalEntries) {
            final parsedDate = DateTime.tryParse(entry.date);
            if (parsedDate != null) {
              moodByDate[_dateKey(parsedDate)] = entry.mood;
            }
          }

          final monthNotes = controller.journalEntries.where((entry) {
            final parsedDate = DateTime.tryParse(entry.date);
            if (parsedDate == null) return false;
            return parsedDate.year == _visibleMonth.year &&
                parsedDate.month == _visibleMonth.month;
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _changeMonth(-1),
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppColors.primarytext,
                      size: 26.sp,
                    ),
                  ),
                  Text(
                    monthTitle,
                    style: AppTextStyle.h6.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeMonth(1),
                    icon: Icon(
                      Icons.chevron_right,
                      color: AppColors.primarytext,
                      size: 26.sp,
                    ),
                  ),
                ],
              ),
              CustomCalendarTwo(
                title: monthTitle.toUpperCase(),
                daysGrid: monthGrid,
                dayColorBuilder: (day) {
                  final dateKey = _dateKey(
                    DateTime(_visibleMonth.year, _visibleMonth.month, day),
                  );
                  final mood = moodByDate[dateKey];
                  if (mood == null) return Colors.white;
                  return _colorFromMood(mood);
                },
              ),
              SizedBox(height: 20.h),
              const MoodLegendRow(),
              SizedBox(height: 20.h),
              Text(
                'Previous Note',
                style: AppTextStyle.h6.copyWith(color: AppColors.primarytext),
              ),

              if (controller.isLoading.value)
                const Center(child: CircularProgressIndicator())
              else if (monthNotes.isEmpty)
                Text(
                  'No journal history found for this month.',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.primarytext,
                  ),
                )
              else
                ListView.builder(
                  itemCount: monthNotes.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final note = monthNotes[index];
                    return NoteCard(
                      date: note.date,
                      title: note.mood,
                      description: note.note,
                      isDismissible: true,
                    );
                  },
                ),
              SizedBox(height: 30.h),
            ],
          );
        }),
      ),
    );
  }
}
