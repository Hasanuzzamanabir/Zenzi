import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool hasToggle;
  final bool isLogout;
  final bool isPremium;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;
  final Widget? leadingWidget;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.hasToggle = false,
    this.isLogout = false,
    this.isPremium = false,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: isFirst ? Radius.circular(8.r) : Radius.zero,
        topRight: isFirst ? Radius.circular(8.r) : Radius.zero,
        bottomLeft: isLast ? Radius.circular(8.r) : Radius.zero,
        bottomRight: isLast ? Radius.circular(8.r) : Radius.zero,
      ),
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          gradient: isPremium
              ? LinearGradient(
                  colors: [Color(0xFFED7A3C), Color(0xFFA17735)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : null,
          color: isPremium ? null : AppColors.coreprimarydark,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                leadingWidget ??
                    Icon(
                      icon,
                      color: isLogout ? Color(0xFFFF6441) : Colors.white,
                      size: 20.sp,
                    ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isLogout ? Color(0xFFFF6441) : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isLogout
                      ? Color(0xFFFF6441)
                      : AppColors.secondarycolor,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
