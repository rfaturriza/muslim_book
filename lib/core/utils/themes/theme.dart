import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quranku/core/constants/font_constants.dart';

import 'color.dart';
import 'text.dart';

final themeData = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor[500],
  primarySwatch: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    accentColor: secondaryColor[500],
    cardColor: secondaryColor[500],
    backgroundColor: backgroundColor,
    errorColor: errorColor[400],
  ),
  iconTheme: IconThemeData(color: defaultColor.shade50),
  dividerColor: secondaryColor[500],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: FontConst.lato,
  textTheme: textTheme,
  tabBarTheme: TabBarTheme(
    labelColor: secondaryColor.shade500,
    labelStyle: textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: secondaryColor.shade500,
    ),
    unselectedLabelColor: defaultColor.shade50.withOpacity(0.5),
    dividerColor: Colors.transparent,
    indicatorColor: secondaryColor.shade500,
    indicatorSize: TabBarIndicatorSize.label,
  ),
  drawerTheme: DrawerThemeData(
    elevation: 0,
    backgroundColor: defaultColor.shade500,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: defaultColor.shade50),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    showDragHandle: true,
    dragHandleColor: defaultColor.shade100,
    dragHandleSize: const Size(32, 4),
    modalElevation: 10,
    backgroundColor: backgroundColor,
    modalBarrierColor: Colors.black.withOpacity(0.2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    dense: true,
    visualDensity: VisualDensity.compact,
    titleTextStyle: textTheme.titleMedium?.copyWith(
      color: defaultColor.shade50,
    ),
    subtitleTextStyle: textTheme.titleSmall?.copyWith(
      color: defaultColor.shade100,
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: backgroundColor,
    titleTextStyle: textTheme.titleMedium?.copyWith(
      color: defaultColor.shade50,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: textTheme.titleSmall?.copyWith(
      color: defaultColor.shade100,
      fontWeight: FontWeight.w500,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      foregroundColor: defaultColor.shade50,
      textStyle: textTheme.titleSmall?.copyWith(
        color: defaultColor.shade50,
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor.shade500;
      }
      return Colors.transparent;
    }),
    overlayColor:
        MaterialStateProperty.all(defaultColor.shade50.withOpacity(0.1)),
    checkColor: MaterialStateProperty.all(defaultColor.shade50),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: defaultColor.shade50,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(2),
    ),
    side: BorderSide(
      color: defaultColor.shade50,
      width: 2,
    ),
  ),
  sliderTheme: SliderThemeData(
    overlayShape: SliderComponentShape.noOverlay,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 8,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: secondaryColor.shade800,
    contentTextStyle: textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
);
