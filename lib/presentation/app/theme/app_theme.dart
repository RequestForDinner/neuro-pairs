import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore_for_file: unused_field

final class AppTheme {
  const AppTheme.light({
    this.mainBackground = _lightSilver,
    this.secondaryBackground = _lightGrey,
    this.nonActiveElementColor = _pastelLightGreen,
    this.activeElementColor = _darkGreen,
    this.secondaryActiveElementColor = _lightGreen,
    this.primaryTextColor = _black,
    this.secondaryTextColor = _darkSilver,
    this.tertiaryTextColor = _darkGrey,
    this.contrastTextColor = _lightSilver,
    this.inactiveTextColor = _darkSilver,
    this.primaryIconColor = _lightBlack,
    this.contrastIconColor = _lightSilver,
    this.backgroundColor = _lightSilver,
    this.errorColor = _darkRed,
  }) : isDark = false;

  const AppTheme.dark({
    this.mainBackground = _lightSilver,
    this.secondaryBackground = _lightGrey,
    this.nonActiveElementColor = _pastelLightGreen,
    this.activeElementColor = _darkGreen,
    this.secondaryActiveElementColor = _lightGreen,
    this.primaryTextColor = _black,
    this.secondaryTextColor = _darkSilver,
    this.tertiaryTextColor = _darkGrey,
    this.contrastTextColor = _lightSilver,
    this.inactiveTextColor = _darkSilver,
    this.primaryIconColor = _lightBlack,
    this.contrastIconColor = _lightSilver,
    this.backgroundColor = _lightSilver,
    this.errorColor = _darkRed,
  }) : isDark = true;

  final Color mainBackground;
  final Color secondaryBackground;
  final Color nonActiveElementColor;

  final Color activeElementColor;
  final Color secondaryActiveElementColor;

  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color contrastTextColor;

  final Color primaryIconColor;
  final Color inactiveTextColor;
  final Color contrastIconColor;

  final Color backgroundColor;
  final Color errorColor;

  final bool isDark;

  ThemeData mainThemeData() => isDark ? _lightThemeData : _lightThemeData;

  ThemeData get _lightThemeData => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _lightSilver,
        iconTheme: const IconThemeData(color: _lightSilver),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        dialogTheme: DialogTheme(
          barrierColor: Colors.black.withOpacity(0.65),
        ),
        tabBarTheme: TabBarTheme(
          dividerHeight: 0,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          labelStyle: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: activeElementColor,
            fontSize: 18.sp,
          ),
          unselectedLabelStyle: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 18.sp,
          ),
        ),
        textTheme: TextTheme(
          bodySmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w300,
            color: primaryTextColor,
            fontSize: 8.sp,
          ),
          bodyMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w300,
            color: primaryTextColor,
            fontSize: 10.sp,
          ),
          bodyLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 12.sp,
          ),
          headlineSmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 14.sp,
          ),
          headlineMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 16.sp,
          ),
          headlineLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 18.sp,
          ),
          titleSmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 20.sp,
          ),
          titleMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontSize: 24.sp,
          ),
          titleLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryTextColor,
            fontSize: 30.sp,
          ),
        ),
      );

  ThemeData get _darkThemeData => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _lightSilver,
        iconTheme: const IconThemeData(color: _lightSilver),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        dialogTheme: DialogTheme(
          barrierColor: Colors.black.withOpacity(0.65),
        ),
        textTheme: TextTheme(
          bodySmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w300,
            color: primaryTextColor,
            fontSize: 10.sp,
          ),
          bodyMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 12.sp,
          ),
          bodyLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 14.sp,
          ),
          headlineSmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 16.sp,
          ),
          headlineMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 18.sp,
          ),
          headlineLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 20.sp,
          ),
          titleSmall: appTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontSize: 24.sp,
          ),
          titleMedium: appTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontSize: 30.sp,
          ),
          titleLarge: appTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryTextColor,
            fontSize: 36.sp,
          ),
        ),
      );

  TextStyle get appTextStyle => const TextStyle(fontFamily: 'Montserrat');

  static const _black = Color(0xFF000000);

  static const _lightBlack = Color(0xFF1F1F1F);
  static const _darkSilver = Color(0xFF8E8E8E);
  static const _lightSilver = Color(0xFFECF0F1);
  static const _lightGrey = Color(0xFFF5F5F7);
  static const _darkGrey = Color(0XFF404040);
  static const _pastelLightGreen = Color(0xFFDBDCDA);

  static const _darkRed = Color(0xFF7d3d3d);
  static const _lightGreen = Color(0xFFC1E1C1);
  static const _darkGreen = Color(0xFF557164);
}
