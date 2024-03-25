import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';

extension LocationPermissionExt on LocationPermission? {
  bool get isGranted {
    return this == LocationPermission.always ||
        this == LocationPermission.whileInUse;
  }

  bool get isNotGranted {
    return this == LocationPermission.denied ||
        this == LocationPermission.deniedForever;
  }
}

extension ListExt<T> on List<T> {
  List<T> takeRandom(int count) {
    final random = Random();
    final shuffledItems = List.of(this)..shuffle(random);
    return shuffledItems.take(count).toList();
  }
}

extension DateTimeExt on DateTime? {
  /// Format date to yyyy-MM-dd
  /// ex: 2021-01-01
  String? get yyyyMMdd {
    try {
      if (this == null) return null;
      return DateFormat('yyyy-MM-dd').format(this!);
    } catch (e) {
      return null;
    }
  }

  /// Format date to dd-MM-yyyy
  /// ex: 01-01-2021
  String get ddMMyyyy {
    try {
      if (this == null) return '';
      return DateFormat('dd-MM-yyyy').format(this!);
    } catch (e) {
      return '';
    }
  }

  /// Format date to dd MMMM yyyy
  /// ex: 01 January 2021
  String? ddMMMMyyyy(Locale? locale) {
    try {
      if (this == null) return null;
      if (locale == null || locale.languageCode.isEmpty) {
        return DateFormat('dd MMMM yyyy').format(this!);
      }
      return DateFormat('dd MMMM yyyy', locale.languageCode).format(this!);
    } catch (e) {
      return null;
    }
  }

  /// Format date to day, dd MMMM yyyy
  /// Rabu, 15 Mei 2023
  String? toEEEEddMMMMyyyy(Locale? locale) {
    try {
      if (this == null) return null;
      if (locale == null || locale.languageCode.isEmpty) {
        return DateFormat('EEEE, dd MMMM yyyy').format(this!);
      }
      return DateFormat('EEEE, dd MMMM yyyy', locale.languageCode)
          .format(this!);
    } catch (e) {
      return null;
    }
  }
}
