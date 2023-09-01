import 'package:flutter/material.dart';

import 'color.dart';
import 'text.dart';

final themeData = ThemeData(
  primaryColor: primaryColor[500],
  primarySwatch: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    accentColor: secondaryColor[500],
    backgroundColor: backgroundColor,
    errorColor: errorColor[500],
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Lato',
  textTheme: textTheme,
);
