import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/app/theme/app_theme.dart';
import 'package:neuro_pairs/presentation/app/theme/app_theme_provider.dart';

extension ThemeExtension on BuildContext {
  AppTheme get appTheme => AppThemeProvider.of(this);

  ThemeData get themeData => AppThemeProvider.of(this).mainThemeData();

  TextTheme get textTheme => themeData.textTheme;
}
