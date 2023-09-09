import 'package:flutter/material.dart';
import 'package:quranku/core/constants/font_constants.dart';

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
    errorColor: errorColor[400],
  ),
  iconTheme: IconThemeData(color: defaultColor.shade50),
  dividerColor: secondaryColor[500],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: FontConst.lato,
  textTheme: textTheme,
);
