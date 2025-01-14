import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/values/colors.dart';
import 'package:smart_task/core/values/fonts.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
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
    primary: AppColors.black,
    onPrimary: Colors.white,
    secondary: const Color(0xFFFAFAFA),
    onSecondary: AppColors.whiteGray7,
    error: AppColors.errorDefault,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    tertiary: const Color(0xFFDBDBDB),
    onTertiary: const Color(0xFF625F6D),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: AppColors.grey.withAlpha(100),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      height: 1.26,
      fontFamily: AppFonts.sora,
      fontSize: 14.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 17.sp,
      color: AppColors.black,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 16.sp,
      color: AppColors.black,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteGray7,
    ),
    //
    titleLarge: TextStyle(
      fontSize: 14.sp,
      color: AppColors.black,
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
      color: const Color(0xFF4C6174),
    ),
    labelMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF4C6174),
    ),

    labelSmall: TextStyle(
      fontSize: 14.sp,
      fontFamily: AppFonts.sora,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF939497),
    ),
  ),
);
