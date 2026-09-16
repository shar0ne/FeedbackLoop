import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBg,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.green,
    surface: AppColors.darkCard,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBg,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);