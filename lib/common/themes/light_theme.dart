import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/variables/app_colors.dart';

ThemeData lightTheme() {
  const String sfProDisplayFont = "SF Pro Display";
  const String montserratFont = "Montserrat";

  TextTheme lightTextTheme(TextTheme base) {
    // для текста таймера
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: montserratFont,
        fontSize: 56.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: montserratFont,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: montserratFont,
        fontSize: 23.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontFamily: montserratFont,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: montserratFont,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: sfProDisplayFont,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontFamily: montserratFont,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: sfProDisplayFont,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontFamily: sfProDisplayFont,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      labelSmall: base.button?.copyWith(
        fontFamily: sfProDisplayFont,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.primaryBackground,
    secondary: AppColors.textDark,
    onSecondary: AppColors.textSecondary,
    background: AppColors.background,
    onBackground: AppColors.grey,
    error: AppColors.error,
    onError: AppColors.errorBackground,
    surface: AppColors.white,
    onSurface: AppColors.buttonPrimary,
  );

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    textTheme: lightTextTheme(lightTheme.textTheme),
    colorScheme: lightColorScheme,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primary),
  );
}
