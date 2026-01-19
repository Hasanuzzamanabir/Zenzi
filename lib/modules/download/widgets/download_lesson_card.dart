import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class DownloadLessonCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final Color backgroundColor;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const DownloadLessonCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.backgroundColor,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: const Color(0x62250580),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(Icons.delete, color: Colors.red, size: 28.sp),
      ),
      child: GestureDetector(
        onTap: onPlay,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.componentnormal, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.secondarycolor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.componentnormal,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          duration,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.componentnormal,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  color: AppColors.secondarycolor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: const Color(0xFF8B5E3C),
                  size: 26.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
