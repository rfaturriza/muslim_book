import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
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

String? extractYouTubeVideoId(String url) {
  RegExp regExpLiveStream = RegExp(
    r'(?:https?://)?(?:www\.)?(?:youtube\.com/live/|youtu\.be/)([a-zA-Z0-9_-]{11})');
RegExp regExpRegularVideo = RegExp(
    r'(?:https?://)?(?:www\.)?(?:youtube\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([a-zA-Z0-9_-]{11})');

final matchLiveStream = regExpLiveStream.firstMatch(url);
  final matchRegularVideo = regExpRegularVideo.firstMatch(url);

  if (matchLiveStream != null && matchLiveStream.groupCount >= 1) {
    return matchLiveStream.group(1);
  } else if (matchRegularVideo != null && matchRegularVideo.groupCount >= 1) {
    return matchRegularVideo.group(1);
  } else {
    return null;
  }
}
class CurrencyInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "id_ID");

    String newText = formatter.format(value/100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
