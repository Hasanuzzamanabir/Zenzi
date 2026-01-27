import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoodLegendRow extends StatelessWidget {
  const MoodLegendRow({super.key});

  // Legend Colors
  static const Color greatColor = Color(0xFF67C367);
  static const Color goodColor = Color(0xFFCACF2C);
  static const Color okayColor = Color(0xFFF5C400);
  static const Color lowColor = Color(0xFFF59E0B);
  static const Color anxiousColor = Color(0xFFF55D0B);

  @override
  Widget build(BuildContext context) {
    const double itemWidth =
        100.0; // Fixed width for each column to ensure alignment

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: itemWidth.w,
              child: const _LegendItem(color: greatColor, label: 'Great'),
            ),
            SizedBox(
              width: itemWidth.w,
              child: const _LegendItem(color: goodColor, label: 'Good'),
            ),
            SizedBox(
              width: itemWidth.w,
              child: const _LegendItem(color: okayColor, label: 'Okay'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SizedBox(
              width: itemWidth.w,
              child: const _LegendItem(color: lowColor, label: 'Low'),
            ),
            SizedBox(
              width: itemWidth.w,
              child: const _LegendItem(color: anxiousColor, label: 'Anxious'),
            ),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Small filled circular dot
        Container(
          width: 16.r, // Increased size
          height: 16.r, // Increased size
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w), // Horizontal spacing
        // Text label
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500, // Medium weight
          ),
        ),
      ],
    );
  }
}
