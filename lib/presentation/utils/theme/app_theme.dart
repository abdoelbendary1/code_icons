import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    canvasColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
      color: AppColors.whiteColor,
    )),
    primaryColor: AppColors.primaryColor,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        )),
  );
}
