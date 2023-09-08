import 'package:quranku/core/utils/extension/string_ext.dart';

String getCityNameWithoutPrefix(String? city) {
  if (city == null) return emptyString;
  final index = (){
    if (city.contains("kota")) {
      return city.indexOf("kota") + 4;
    } else if (city.contains("kabupaten")) {
      return city.indexOf("kabupaten") + 9;
    } else if (city.contains("kab")) {
      return city.indexOf("kab") + 3;
    } else {
      return 0;
    }
  }();
  final getStringAfterIndex = city.substring(index);
  final removeSpace = getStringAfterIndex.replaceAll(" ", "").trim();
  return removeSpace.toLowerCase();
}
