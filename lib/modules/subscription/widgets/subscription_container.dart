import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

class FeatureAccessCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String subtitle;
  final String freeDescription;
  final String premiumDescription;
  final VoidCallback? onTap;

  const FeatureAccessCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.freeDescription,
    required this.premiumDescription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundhorizon,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primarylight, width: 1.5.w),
        ),
        child: Row(
          children: [
            // Circular Icon Container
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF38B6C), Color(0xFFD15539)],
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                iconAsset,
                width: 24.w,
                height: 24.h,
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 16.w),

            // Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(title, style: AppTextStyle.h7),
                  SizedBox(height: 4.h),

                  // Subtitle
                  Text(subtitle, style: AppTextStyle.h6),
                  SizedBox(height: 8.h),

                  // Free and Premium Availability
                  Row(
                    children: [
                      // Free Status
                      Text('Free: ', style: AppTextStyle.h10),
                      Text(freeDescription, style: AppTextStyle.h10),
                      SizedBox(width: 16.w),

                      // Premium Status
                      Text('Premium: ', style: AppTextStyle.h10),
                      Text(premiumDescription, style: AppTextStyle.h10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
