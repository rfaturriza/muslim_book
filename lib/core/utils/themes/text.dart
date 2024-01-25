import 'package:flutter/material.dart';
import 'package:quranku/core/utils/themes/color.dart';

final textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 86,
    color: defaultColor.shade50,
    letterSpacing: -1.5,
  ),
  displayMedium: TextStyle(
    fontSize: 53,
    color: defaultColor.shade50,
    letterSpacing: -0.5,
  ),
  displaySmall: TextStyle(
    fontSize: 43,
    color: defaultColor.shade50,
  ),
  headlineMedium: TextStyle(
    fontSize: 30,
    color: defaultColor.shade50,
    letterSpacing: 0.25,
  ),
  headlineSmall: TextStyle(
    fontSize: 21,
    color: defaultColor.shade50,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    color: defaultColor.shade50,
    letterSpacing: 0,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: TextStyle(
    fontSize: 14,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 12,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: TextStyle(
    fontSize: 18,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: TextStyle(
    fontSize: 11,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: TextStyle(
    fontSize: 9,
    color: defaultColor.shade50,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
).apply(
  fontFamily: 'Lato',
);
