import 'package:flutter/material.dart';

import 'color_schemes.dart';

TextTheme textThemeStyle({required bool isDarkMode}) {
  final defaultColor =
      isDarkMode ? darkColorScheme.onSurface : lightColorScheme.onSurface;
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 86,
      color: defaultColor,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontSize: 53,
      color: defaultColor,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(
      fontSize: 43,
      color: defaultColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: defaultColor,
      letterSpacing: 0.25,
    ),
    headlineSmall: TextStyle(
      fontSize: 21,
      color: defaultColor,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      color: defaultColor,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: defaultColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: defaultColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: defaultColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      color: defaultColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      color: defaultColor,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: 11,
      color: defaultColor,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelSmall: TextStyle(
      fontSize: 9,
      color: defaultColor,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: defaultColor,
      fontWeight: FontWeight.w400,
    ),
  ).apply(
    fontFamily: 'Lato',
  );
}
