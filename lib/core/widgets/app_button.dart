// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.leading,
    this.trailing,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 46.h, // figma height
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primarycolor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primarycolor.withOpacity(0.5),
              offset: const Offset(0, 2),
              blurRadius: 13.7,
            ),
          ],
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.h,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondarycolor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[leading!, SizedBox(width: 10.w)],
                  Text(
                    title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (trailing != null) ...[SizedBox(width: 10.w), trailing!],
                ],
              ),
      ),
    );
  }
}
