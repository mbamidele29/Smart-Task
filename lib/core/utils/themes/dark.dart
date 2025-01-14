import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/values/colors.dart';
import 'package:smart_task/core/values/fonts.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  inputDecorationTheme: InputDecorationTheme(
    constraints: BoxConstraints(minHeight: 70.h),
    contentPadding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 16.h),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide: BorderSide(color: AppColors.whiteGray1)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide: BorderSide(color: AppColors.errorDefault)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide: BorderSide(color: AppColors.whiteGray1)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide: BorderSide(color: AppColors.whiteGray1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.r),
        borderSide: BorderSide(color: AppColors.blue)),
    suffixIconConstraints: BoxConstraints(maxHeight: 26.h),
    errorStyle: TextStyle(
      fontSize: 12.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w400,
      color: AppColors.errorDefault,
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: AppFonts.sora,
      fontSize: 14.sp,
      color: AppColors.placeHolder,
      // height: 1,
    ),
    filled: true,
    isDense: true,
    fillColor: AppColors.whiteGray1,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: const Color(0xFF1F1F1F),
    onSecondary: Colors.white,
    error: AppColors.errorDefault,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.white,
    tertiary: const Color(0xFFDBDBDB),
    onTertiary: const Color(0xFF625F6D),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    margin: EdgeInsets.zero,
    color: Color(0xFF020206),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFF020206),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF020206),
    surfaceTintColor: Color(0xFF020206),
    shadowColor: AppColors.whiteGray1.withAlpha(100),
    iconTheme: IconThemeData(color: Color(0xFF020206)),
    titleTextStyle: TextStyle(
      height: 1.26,
      fontFamily: AppFonts.sora,
      fontSize: 14.sp,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 17.sp,
      color: Colors.white,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 16.sp,
      color: Colors.white,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w400,
    ),
    //
    titleLarge: TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 12.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w500,
      color: const Color(0XFF717171),
    ),
    titleSmall: TextStyle(
      fontSize: 11.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w500,
      color: const Color(0XFF717171),
    ),

    labelLarge: TextStyle(
      fontSize: 16.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w800,
      color: Colors.white.withAlpha(204),
    ),
    labelMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w400,
      color: Colors.white.withAlpha(204),
    ),

    labelSmall: TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF939497),
    ),
  ),
);
