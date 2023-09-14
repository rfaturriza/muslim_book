import 'package:quranku/generated/locale_keys.g.dart';

extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  bool get isNotGrantedPermissionLocation {
    return this == LocaleKeys.errorLocationDenied || this == LocaleKeys.errorLocationPermanentDenied;
  }
}

extension StringExtNullSafety on String? {
  String orEmpty() {
    return this ?? '';
  }
}

const emptyString = '';