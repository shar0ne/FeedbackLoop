import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBg,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.green,
    surface: AppColors.lightCard,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBg,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);