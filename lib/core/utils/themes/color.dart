import 'package:flutter/material.dart';

import 'color_schemes.dart';

final primaryColor = MaterialColor(
  lightColorScheme.primary.value,
  <int, Color>{
    50: lightColorScheme.primary.withOpacity(0.1),
    100: lightColorScheme.primary.withOpacity(0.2),
    200: lightColorScheme.primary.withOpacity(0.3),
    300: lightColorScheme.primary.withOpacity(0.4),
    400: lightColorScheme.primary.withOpacity(0.5),
    500: lightColorScheme.primary.withOpacity(0.6),
    600: lightColorScheme.primary.withOpacity(0.7),
    700: lightColorScheme.primary.withOpacity(0.8),
    800: lightColorScheme.primary.withOpacity(0.9),
    900: lightColorScheme.primary,
  },
);

final secondaryColor = MaterialColor(
  lightColorScheme.secondary.value,
  <int, Color>{
    50: lightColorScheme.secondary.withOpacity(0.1),
    100: lightColorScheme.secondary.withOpacity(0.2),
    200: lightColorScheme.secondary.withOpacity(0.3),
    300: lightColorScheme.secondary.withOpacity(0.4),
    400: lightColorScheme.secondary.withOpacity(0.5),
    500: lightColorScheme.secondary.withOpacity(0.6),
    600: lightColorScheme.secondary.withOpacity(0.7),
    700: lightColorScheme.secondary.withOpacity(0.8),
    800: lightColorScheme.secondary.withOpacity(0.9),
    900: lightColorScheme.secondary,
  },
);

final defaultColor = MaterialColor(
  lightColorScheme.onPrimary.value,
  <int, Color>{
    50: lightColorScheme.onPrimary.withOpacity(0.1),
    100: lightColorScheme.onPrimary.withOpacity(0.2),
    200: lightColorScheme.onPrimary.withOpacity(0.3),
    300: lightColorScheme.onPrimary.withOpacity(0.4),
    400: lightColorScheme.onPrimary.withOpacity(0.5),
    500: lightColorScheme.onPrimary.withOpacity(0.6),
    600: lightColorScheme.onPrimary.withOpacity(0.7),
    700: lightColorScheme.onPrimary.withOpacity(0.8),
    800: lightColorScheme.onPrimary.withOpacity(0.9),
    900: lightColorScheme.onPrimary,
  },
);

final errorColor = MaterialColor(
  lightColorScheme.error.value,
  <int, Color>{
    50: lightColorScheme.error.withOpacity(0.1),
    100: lightColorScheme.error.withOpacity(0.2),
    200: lightColorScheme.error.withOpacity(0.3),
    300: lightColorScheme.error.withOpacity(0.4),
    400: lightColorScheme.error.withOpacity(0.5),
    500: lightColorScheme.error.withOpacity(0.6),
    600: lightColorScheme.error.withOpacity(0.7),
    700: lightColorScheme.error.withOpacity(0.8),
    800: lightColorScheme.error.withOpacity(0.9),
    900: lightColorScheme.error,
  },
);

final backgroundColor = lightColorScheme.background;
