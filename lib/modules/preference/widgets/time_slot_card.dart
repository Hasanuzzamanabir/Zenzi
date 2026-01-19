import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class TimeSlotCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A2E1A) : const Color(0xFFD9A15B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.darktext),
        ),
        child: Row(
          children: [
            /// ✅ ASSET ICON DIRECTLY
            icon,

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primarylight
                          : AppColors.primarytext,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primarylight
                          : AppColors.primarytext,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF9C5B22,
                  ), // Brown color from your screenshot
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: isSelected
                      ? AppColors.primarylight
                      : AppColors.primarytext,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
