import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quranku/core/constants/hive_constants.dart';

import 'core/utils/themes/color_schemes.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.system;
  late ColorScheme _darkScheme = darkColorScheme;
  late ColorScheme _lightScheme = lightColorScheme;

  void init() {
    getThemeMode();
  }

  void getThemeMode() async {
    var box = await Hive.openBox(HiveConst.themeModeBox);
    const key = HiveConst.themeModeKey;
    final String themeMode = box.get(key, defaultValue: ThemeMode.system.name);
    if (themeMode == ThemeMode.system.name) {
      _themeMode = ThemeMode.system;
    } else if (themeMode == ThemeMode.light.name) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    var box = Hive.box(HiveConst.themeModeBox);
    const key = HiveConst.themeModeKey;
    box.put(key, value.name);
    notifyListeners();
  }

  ColorScheme get darkScheme => _darkScheme;

  void setDarkScheme(ColorScheme value) {
    _darkScheme = value;
    notifyListeners();
  }

  ColorScheme get lightScheme => _lightScheme;

  void setLightScheme(ColorScheme value) {
    _lightScheme = value;
    notifyListeners();
  }
}
