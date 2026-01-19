import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  // ================= SPLASH =================
  static const TextStyle splashTitle = TextStyle(
    fontFamily: 'Acme',
    fontSize: 64,
    fontWeight: FontWeight.w400,
    height: 0.86,
    letterSpacing: 0,
    color: AppColors.secondarycolor,
  );

  // ================= HEADINGS =================
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.primarytext,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.2,
    color: AppColors.secondarycolor,
  );
  static const TextStyle h4 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  static const TextStyle h5 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.secondarycolor,
  );
  static const TextStyle h6 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.secondarycolor,
  );
  static const TextStyle h7 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.primarytext,
  );
  static const TextStyle h8 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    height: 1.2,
    color: AppColors.primarytext,
  );
  static const TextStyle h9 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.2,
    color: AppColors.primarytext,
  );
  static const TextStyle h10 = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0.2,
    color: AppColors.secondarycolor,
  );
  // ================= BODY =================
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  static const TextStyle bodyMediumBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // ================= BUTTON =================
  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  // ================= CAPTION =================
  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
}
