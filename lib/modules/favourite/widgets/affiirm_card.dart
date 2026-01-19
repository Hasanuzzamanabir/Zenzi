import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AffirmCard extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool showFavoriteIcon;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onLongPress;

  const AffirmCard({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.showFavoriteIcon = true,
    this.onFavoriteTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            if (showFavoriteIcon)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(Icons.favorite, color: Colors.red, size: 20.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
