import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arabic_font/arabic_font.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    canvasColor: AppColors.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryColor,
        selectedIconTheme: IconThemeData(
          color: AppColors.whiteColor,
        ),
        selectedItemColor: AppColors.whiteColor,
        type: BottomNavigationBarType.shifting),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
        )),
    fontFamily: ArabicThemeData.font(arabicFont: ArabicFont.dinNextLTArabic),
    package: ArabicThemeData.package,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryColor,
    textTheme: const TextTheme(
        titleLarge: ArabicTextStyle(
          arabicFont: ArabicFont.dinNextLTArabic,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        titleMedium: ArabicTextStyle(
          arabicFont: ArabicFont.dinNextLTArabic,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        bodyLarge: ArabicTextStyle(
          arabicFont: ArabicFont.dinNextLTArabic,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        )),
  );
}
