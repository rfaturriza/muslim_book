import 'dart:convert';

import 'package:quranku/generated/locale_keys.g.dart';

extension StringExt on String {
  String capitalize() {
   return isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
  }

  String capitalizeEveryWord() {
    return split(" ")
        .map((str) => str.isEmpty ? str : "${str[0].toUpperCase()}${str.substring(1)}")
        .join(" ");
  }

  bool get isNotGrantedPermissionLocation {
    return this == LocaleKeys.errorLocationDenied || this == LocaleKeys.errorLocationPermanentDenied;
  }

  String toBase64() {
    return base64.encode(utf8.encode(this));
  }

  String fromBase64() {
    return utf8.decode(base64.decode(this));
  }
}

extension StringExtNullSafety on String? {
  String orEmpty() {
    return this ?? '';
  }
}

const emptyString = '';