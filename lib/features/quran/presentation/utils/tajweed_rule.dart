import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'tajweed_rule.g.dart';

@HiveType(typeId: 2)
enum TajweedRule {
  @HiveField(0)
  LAFZATULLAH(1,
      color: Colors.green, darkThemeColor: Color.fromRGBO(129, 199, 132, 1)),
  @HiveField(1)
  izhar(2,
      color: Color.fromARGB(255, 6, 176, 182),
      darkThemeColor: Color.fromARGB(255, 111, 240, 245)),
  @HiveField(2)
  ikhfaa(3,
      color: Color(0xFFB71C1C),
      darkThemeColor: Color.fromARGB(255, 250, 68, 68)),
  @HiveField(3)
  idghamWithGhunna(4, color: Color(0xFFF06292)),
  @HiveField(4)
  iqlab(5, color: Colors.blue),
  @HiveField(5)
  qalqala(6,
      color: Color.fromARGB(255, 123, 143, 10),
      darkThemeColor: Color.fromARGB(255, 214, 240, 70)),
  @HiveField(6)
  idghamWithoutGhunna(7, color: Colors.grey),
  @HiveField(7)
  ghunna(8, color: Colors.orange),
  @HiveField(8)
  prolonging(9,
      color: Color.fromARGB(255, 142, 100, 214),
      darkThemeColor: Color.fromARGB(255, 191, 165, 236)),
  @HiveField(9)
  alefTafreeq(10, color: Colors.grey),
  @HiveField(10)
  hamzatulWasli(11, color: Colors.grey),
  //marsoomKhilafLafzi(12, color: Colors.grey),

  @HiveField(11)
  none(100, color: null);

  const TajweedRule(
    this.priority, {
    required Color? color,
    Color? darkThemeColor,
  })  : _color = color,
        _darkThemeColor = darkThemeColor;

  final int priority;
  final Color? _color;
  final Color? _darkThemeColor;

  Color? color(BuildContext context) {
    if (_darkThemeColor == null) {
      return _color;
    }

    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme ? _darkThemeColor : _color;
  }
}
