import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/custom_themes/app_bar_theme.dart';
import 'package:zenzi/core/theme/custom_themes/elevated_button_theme.dart';
import 'package:zenzi/core/theme/custom_themes/text_field_theme.dart';
import 'package:zenzi/core/theme/custom_themes/text_theme.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  // Theme Constants
  static const Color dayBackgroundColor = AppColors.primarydarker;
  static const List<Color> nightBackgroundColors = [
    AppColors.appnightmode1,
    AppColors.appnightmode2,
  ];

  static const Gradient nightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: nightBackgroundColors,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Acme',
    brightness: Brightness.light,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: dayBackgroundColor,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: App_BarTheme.lightAppBarTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Acme',
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: AppColors.appnightmode1,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: App_BarTheme.darkAppBarTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}
