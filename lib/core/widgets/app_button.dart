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
  final bool isEnabled;

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
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = isEnabled && !isLoading;
    final buttonColor = backgroundColor ?? AppColors.primarycolor;

    return GestureDetector(
      onTap: isButtonEnabled ? onTap : null,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 46.h, // figma height
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isButtonEnabled
              ? [
                  BoxShadow(
                    color: buttonColor.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 13.7,
                  ),
                ]
              : [],
        ),
        child: isLoading
            ? SizedBox(
                height: 10.h,
                width: 10.w,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondarycolor,
                    strokeWidth: 2.5,
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
