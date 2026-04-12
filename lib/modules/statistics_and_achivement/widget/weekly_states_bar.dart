// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class WeeklyStatsBar extends StatelessWidget {
  final List<double> meditationData;
  final List<double> musicData;
  final List<double> breathingData;

  const WeeklyStatsBar({
    super.key,
    required this.meditationData,
    required this.musicData,
    required this.breathingData,
  });

  @override
  Widget build(BuildContext context) {
    final safeMeditation = _normalizeToWeek(meditationData);
    final safeMusic = _normalizeToWeek(musicData);
    final safeBreathing = _normalizeToWeek(breathingData);
    final chartMaxY = _computeMaxY(safeMeditation, safeMusic, safeBreathing);
    final interval = chartMaxY <= 60 ? 10.0 : 30.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week\'s Stats (minutes)',
            style: TextStyle(
              color: AppColors.primarytext,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: chartMaxY,
                barTouchData: BarTouchData(enabled: false),
                groupsSpace: 24,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      reservedSize: 40.w,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: AppColors.secondarycolor,
                            fontSize: 10.sp,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        if (value.toInt() >= 0 && value.toInt() < days.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              days[value.toInt()],
                              style: TextStyle(
                                color: AppColors.secondarycolor,
                                fontSize: 10.sp,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.secondarytext.withOpacity(0.2),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: _buildBarGroups(
                  safeMeditation,
                  safeMusic,
                  safeBreathing,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(AppColors.componentnormal, 'Meditation'),
              SizedBox(width: 20.w),
              _buildLegend(AppColors.coreprimarydark, 'Music'),
              SizedBox(width: 20.w),
              _buildLegend(AppColors.breathingcolor1, 'Breathing'),
            ],
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
    List<double> meditation,
    List<double> music,
    List<double> breathing,
  ) {
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barsSpace: 3,
        barRods: [
          BarChartRodData(
            toY: meditation[index],
            color: AppColors.componentnormal,
            width: 10.w,
            borderRadius: BorderRadius.circular(35.r),
          ),
          BarChartRodData(
            toY: music[index],
            color: AppColors.coreprimarydark,
            width: 10.w,
            borderRadius: BorderRadius.circular(35.r),
          ),
          BarChartRodData(
            toY: breathing[index],
            color: AppColors.breathingcolor1,
            width: 10.w,
            borderRadius: BorderRadius.circular(35.r),
          ),
        ],
      );
    });
  }

  List<double> _normalizeToWeek(List<double> source) {
    if (source.length >= 7) {
      return source.take(7).toList();
    }
    return [...source, ...List<double>.filled(7 - source.length, 0)];
  }

  double _computeMaxY(
    List<double> meditation,
    List<double> music,
    List<double> breathing,
  ) {
    final all = <double>[...meditation, ...music, ...breathing];
    final maxValue = all.isEmpty ? 0 : all.reduce((a, b) => a > b ? a : b);

    if (maxValue <= 30) {
      return 30;
    }
    return ((maxValue / 30).ceil() * 30).toDouble();
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(color: AppColors.primarytext, fontSize: 12.sp),
        ),
      ],
    );
  }
}
