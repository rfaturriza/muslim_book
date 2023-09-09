import 'package:quranku/core/utils/extension/string_ext.dart';

String getCityNameWithoutPrefix(String? city) {
  if (city == null) return emptyString;
  final prefixes = ["kota", "kabupaten", "kab"];

  for (final prefix in prefixes) {
    if (city.toLowerCase().contains(prefix)) {
      final index = city.toLowerCase().indexOf(prefix) + prefix.length;
      final cityName = city.substring(index).trim();
      return cityName.toLowerCase();
    }
  }
  return city.toLowerCase();
}
