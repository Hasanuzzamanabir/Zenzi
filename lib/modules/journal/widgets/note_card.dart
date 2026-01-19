import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.date,
    required this.title,
    required this.description,
    this.onDismissed,
    this.isDismissible = true,
  });

  final String date;
  final String title;
  final String description;
  final VoidCallback? onDismissed;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.congratsscrennbuttonclr,
        borderRadius: BorderRadius.circular(20.r),

        border: Border.all(color: AppColors.primarylight, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: $date',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            description,
            style: TextStyle(
              color: AppColors.secondarycolor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );

    if (!isDismissible) {
      return cardContent;
    }

    return Dismissible(
      key: Key('${date}__${description}'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismissed?.call();
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.appbarcolortwo,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(Icons.delete_outline, color: Colors.red, size: 32.sp),
      ),
      child: cardContent,
    );
  }
}
