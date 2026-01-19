// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class WeeklyStatsBar extends StatelessWidget {
  final List<double> meditationData;
  final List<double> musicData;

  const WeeklyStatsBar({
    super.key,
    required this.meditationData,
    required this.musicData,
  });

  @override
  Widget build(BuildContext context) {
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
                maxY: 150,
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
                      interval: 30,
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
                  horizontalInterval: 30,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.secondarytext.withOpacity(0.2),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: _buildBarGroups(),
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
            ],
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: meditationData[index],
            color: AppColors.componentnormal,
            width: 16.w,
            borderRadius: BorderRadius.circular(35.r),
          ),
          BarChartRodData(
            toY: musicData[index],
            color: AppColors.coreprimarydark,
            width: 16.w,
            borderRadius: BorderRadius.circular(35.r),
          ),
        ],
      );
    });
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
