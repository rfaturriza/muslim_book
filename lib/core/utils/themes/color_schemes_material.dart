import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff006875),
      surfaceTint: Color(0xff006875),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9eefff),
      onPrimaryContainer: Color(0xff001f24),
      secondary: Color(0xff8e4958),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd9df),
      onSecondaryContainer: Color(0xff3a0717),
      tertiary: Color(0xff825513),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffddb7),
      onTertiaryContainer: Color(0xff2a1700),
      error: Color(0xff904a45),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff3b0908),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171d1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171d1e),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797b),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffecf2f3),
      inversePrimary: Color(0xff82d3e2),
      primaryFixed: Color(0xff9eefff),
      onPrimaryFixed: Color(0xff001f24),
      primaryFixedDim: Color(0xff82d3e2),
      onPrimaryFixedVariant: Color(0xff004e59),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff3a0717),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff713341),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xfff7bb70),
      onTertiaryFixedVariant: Color(0xff653e00),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004a54),
      surfaceTint: Color(0xff006875),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff267f8d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff6c2f3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa85f6e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5f3b00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9b6b28),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff6e302b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffaa5f5a),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171d1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171d1e),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff3b4446),
      outline: Color(0xff576163),
      outlineVariant: Color(0xff737c7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffecf2f3),
      inversePrimary: Color(0xff82d3e2),
      primaryFixed: Color(0xff267f8d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006672),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa85f6e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff8b4756),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9b6b28),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7f5310),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00272c),
      surfaceTint: Color(0xff006875),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004a54),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff430e1e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c2f3d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff331d00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5f3b00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff44100e),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e302b),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171d1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe4e6),
      onSurfaceVariant: Color(0xff1d2527),
      outline: Color(0xff3b4446),
      outlineVariant: Color(0xff3b4446),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffc2f5ff),
      primaryFixed: Color(0xff004a54),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003239),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c2f3d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff511928),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5f3b00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff412700),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff82d3e2),
      surfaceTint: Color(0xff82d3e2),
      onPrimary: Color(0xff00363e),
      primaryContainer: Color(0xff004e59),
      onPrimaryContainer: Color(0xff9eefff),
      secondary: Color(0xffffb1c0),
      onSecondary: Color(0xff551d2b),
      secondaryContainer: Color(0xff713341),
      onSecondaryContainer: Color(0xffffd9df),
      tertiary: Color(0xfff7bb70),
      onTertiary: Color(0xff462a00),
      tertiaryContainer: Color(0xff653e00),
      onTertiaryContainer: Color(0xffffddb7),
      error: Color(0xffffb3ad),
      onError: Color(0xff571e1b),
      errorContainer: Color(0xff73332f),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0e1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0e1416),
      onSurface: Color(0xffdee3e5),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff006875),
      primaryFixed: Color(0xff9eefff),
      onPrimaryFixed: Color(0xff001f24),
      primaryFixedDim: Color(0xff82d3e2),
      onPrimaryFixedVariant: Color(0xff004e59),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff3a0717),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff713341),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xfff7bb70),
      onTertiaryFixedVariant: Color(0xff653e00),
      surfaceDim: Color(0xff0e1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff86d7e6),
      surfaceTint: Color(0xff82d3e2),
      onPrimary: Color(0xff001a1e),
      primaryContainer: Color(0xff499caa),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffb8c4),
      onSecondary: Color(0xff330312),
      secondaryContainer: Color(0xffc87a8a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffcbf74),
      onTertiary: Color(0xff231300),
      tertiaryContainer: Color(0xffbb8641),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab3),
      onError: Color(0xff330405),
      errorContainer: Color(0xffcc7b74),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0e1416),
      onSurface: Color(0xfff6fcfd),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xffc3cccf),
      outline: Color(0xff9ba5a7),
      outlineVariant: Color(0xff7b8587),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff252b2c),
      inversePrimary: Color(0xff00505a),
      primaryFixed: Color(0xff9eefff),
      onPrimaryFixed: Color(0xff001418),
      primaryFixedDim: Color(0xff82d3e2),
      onPrimaryFixedVariant: Color(0xff003c45),
      secondaryFixed: Color(0xffffd9df),
      onSecondaryFixed: Color(0xff2c000d),
      secondaryFixedDim: Color(0xffffb1c0),
      onSecondaryFixedVariant: Color(0xff5d2231),
      tertiaryFixed: Color(0xffffddb7),
      onTertiaryFixed: Color(0xff1c0e00),
      tertiaryFixedDim: Color(0xfff7bb70),
      onTertiaryFixedVariant: Color(0xff4e2f00),
      surfaceDim: Color(0xff0e1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff2fdff),
      surfaceTint: Color(0xff82d3e2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff86d7e6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffb8c4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffcbf74),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab3),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0e1416),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f484a),
      onSurfaceVariant: Color(0xfff3fcff),
      outline: Color(0xffc3cccf),
      outlineVariant: Color(0xffc3cccf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002f36),
      primaryFixed: Color(0xffaff2ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff86d7e6),
      onPrimaryFixedVariant: Color(0xff001a1e),
      secondaryFixed: Color(0xffffdfe3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb8c4),
      onSecondaryFixedVariant: Color(0xff330312),
      tertiaryFixed: Color(0xffffe2c3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffcbf74),
      onTertiaryFixedVariant: Color(0xff231300),
      surfaceDim: Color(0xff0e1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surfaceContainer: surfaceContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
