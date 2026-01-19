import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/widgets/custom%20calender/calender_colors.dart';
//import '../../core/theme/calendar_colors.dart';

class WeekdayLabel extends StatelessWidget {
  final String text;
  const WeekdayLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: CalendarColors.textCream,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
