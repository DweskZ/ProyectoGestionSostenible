import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50);        // Verde musgo
  static const secondary = Color(0xFF1B4965);      // Azul profundo
  static const accent1 = Color(0xFFFFCA28);        // Amarillo cálido
  static const accent2 = Color(0xFFD96C06);        // Terracota
  static const background = Color(0xFFF5F5F5);     // Fondo claro
  static const surfaceDark = Color(0xFF0A0E21);    // Fondo oscuro
  static const textDark = Color(0xFF212121);       // Texto oscuro
  static const textLight = Color(0xFFFFFFFF);      // Texto claro
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.textLight,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textLight,
    surface: AppColors.background,
    onSurface: AppColors.textDark,
    error: Colors.red,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textLight,
    elevation: 0,
  ),
  useMaterial3: true,
);
