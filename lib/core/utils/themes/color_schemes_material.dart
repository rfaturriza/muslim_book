import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278216821),
      surfaceTint: Color(4278216821),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288606207),
      onPrimaryContainer: Color(4278198052),
      secondary: Color(4287514968),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294957535),
      onSecondaryContainer: Color(4281992983),
      tertiary: Color(4286731539),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958519),
      onTertiaryContainer: Color(4280948480),
      error: Color(4287646277),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282059016),
      background: Color(4294310652),
      onBackground: Color(4279704862),
      surface: Color(4294310652),
      onSurface: Color(4279704862),
      surfaceVariant: Color(4292601062),
      onSurfaceVariant: Color(4282337354),
      outline: Color(4285495675),
      outlineVariant: Color(4290758858),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inverseOnSurface: Color(4293718771),
      inversePrimary: Color(4286764002),
      primaryFixed: Color(4288606207),
      onPrimaryFixed: Color(4278198052),
      primaryFixedDim: Color(4286764002),
      onPrimaryFixedVariant: Color(4278210137),
      secondaryFixed: Color(4294957535),
      onSecondaryFixed: Color(4281992983),
      secondaryFixedDim: Color(4294947264),
      onSecondaryFixedVariant: Color(4285608769),
      tertiaryFixed: Color(4294958519),
      onTertiaryFixed: Color(4280948480),
      tertiaryFixedDim: Color(4294425456),
      onTertiaryFixedVariant: Color(4284825088),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278209108),
      surfaceTint: Color(4278216821),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280713101),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4285280061),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289224558),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284431104),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288375592),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285411371),
      onError: Color(4294967295),
      errorContainer: Color(4289355610),
      onErrorContainer: Color(4294967295),
      background: Color(4294310652),
      onBackground: Color(4279704862),
      surface: Color(4294310652),
      onSurface: Color(4279704862),
      surfaceVariant: Color(4292601062),
      onSurfaceVariant: Color(4282074182),
      outline: Color(4283916643),
      outlineVariant: Color(4285758590),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inverseOnSurface: Color(4293718771),
      inversePrimary: Color(4286764002),
      primaryFixed: Color(4280713101),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278216306),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4289224558),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4287317846),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288375592),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286534416),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278200108),
      surfaceTint: Color(4278216821),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278209108),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282584606),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285280061),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281539840),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284431104),
      onTertiaryContainer: Color(4294967295),
      error: Color(4282650638),
      onError: Color(4294967295),
      errorContainer: Color(4285411371),
      onErrorContainer: Color(4294967295),
      background: Color(4294310652),
      onBackground: Color(4279704862),
      surface: Color(4294310652),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292601062),
      onSurfaceVariant: Color(4280100135),
      outline: Color(4282074182),
      outlineVariant: Color(4282074182),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020723),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4290967039),
      primaryFixed: Color(4278209108),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202937),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285280061),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283504936),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284431104),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282459904),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205532),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916150),
      surfaceContainer: Color(4293521392),
      surfaceContainerHigh: Color(4293126634),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4286764002),
      surfaceTint: Color(4286764002),
      onPrimary: Color(4278203966),
      primaryContainer: Color(4278210137),
      onPrimaryContainer: Color(4288606207),
      secondary: Color(4294947264),
      onSecondary: Color(4283768107),
      secondaryContainer: Color(4285608769),
      onSecondaryContainer: Color(4294957535),
      tertiary: Color(4294425456),
      onTertiary: Color(4282788352),
      tertiaryContainer: Color(4284825088),
      onTertiaryContainer: Color(4294958519),
      error: Color(4294947757),
      onError: Color(4283899419),
      errorContainer: Color(4285739823),
      onErrorContainer: Color(4294957782),
      background: Color(4279112726),
      onBackground: Color(4292797413),
      surface: Color(4279112726),
      onSurface: Color(4292797413),
      surfaceVariant: Color(4282337354),
      onSurfaceVariant: Color(4290758858),
      outline: Color(4287206036),
      outlineVariant: Color(4282337354),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4281020723),
      inversePrimary: Color(4278216821),
      primaryFixed: Color(4288606207),
      onPrimaryFixed: Color(4278198052),
      primaryFixedDim: Color(4286764002),
      onPrimaryFixedVariant: Color(4278210137),
      secondaryFixed: Color(4294957535),
      onSecondaryFixed: Color(4281992983),
      secondaryFixedDim: Color(4294947264),
      onSecondaryFixedVariant: Color(4285608769),
      tertiaryFixed: Color(4294958519),
      onTertiaryFixed: Color(4280948480),
      tertiaryFixedDim: Color(4294425456),
      onTertiaryFixedVariant: Color(4284825088),
      surfaceDim: Color(4279112726),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287027174),
      surfaceTint: Color(4286764002),
      onPrimary: Color(4278196766),
      primaryContainer: Color(4283014314),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294949060),
      onSecondary: Color(4281533202),
      secondaryContainer: Color(4291328650),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294754164),
      onTertiary: Color(4280488704),
      tertiaryContainer: Color(4290479681),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949555),
      onError: Color(4281533445),
      errorContainer: Color(4291591028),
      onErrorContainer: Color(4278190080),
      background: Color(4279112726),
      onBackground: Color(4292797413),
      surface: Color(4279112726),
      onSurface: Color(4294376701),
      surfaceVariant: Color(4282337354),
      onSurfaceVariant: Color(4291022031),
      outline: Color(4288390567),
      outlineVariant: Color(4286285191),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4280625964),
      inversePrimary: Color(4278210650),
      primaryFixed: Color(4288606207),
      onPrimaryFixed: Color(4278195224),
      primaryFixedDim: Color(4286764002),
      onPrimaryFixedVariant: Color(4278205509),
      secondaryFixed: Color(4294957535),
      onSecondaryFixed: Color(4281073677),
      secondaryFixedDim: Color(4294947264),
      onSecondaryFixedVariant: Color(4284293681),
      tertiaryFixed: Color(4294958519),
      onTertiaryFixed: Color(4280028672),
      tertiaryFixedDim: Color(4294425456),
      onTertiaryFixedVariant: Color(4283313920),
      surfaceDim: Color(4279112726),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294114815),
      surfaceTint: Color(4286764002),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4287027174),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965753),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4294949060),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966007),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294754164),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949555),
      onErrorContainer: Color(4278190080),
      background: Color(4279112726),
      onBackground: Color(4292797413),
      surface: Color(4279112726),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282337354),
      onSurfaceVariant: Color(4294180095),
      outline: Color(4291022031),
      outlineVariant: Color(4291022031),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278202166),
      primaryFixed: Color(4289721087),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4287027174),
      onPrimaryFixedVariant: Color(4278196766),
      secondaryFixed: Color(4294959075),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4294949060),
      onSecondaryFixedVariant: Color(4281533202),
      tertiaryFixed: Color(4294959811),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294754164),
      onTertiaryFixedVariant: Color(4280488704),
      surfaceDim: Color(4279112726),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783760),
      surfaceContainerLow: Color(4279704862),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625964),
      surfaceContainerHighest: Color(4281349687),
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
        scaffoldBackgroundColor: colorScheme.background,
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
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
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
