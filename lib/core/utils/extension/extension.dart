import 'dart:math';

import 'package:geolocator/geolocator.dart';

extension LocationPermissionExt on LocationPermission? {
  bool get isGranted {
    return this == LocationPermission.always || this == LocationPermission.whileInUse;
  }

  bool get isNotGranted {
    return this == LocationPermission.denied || this == LocationPermission.deniedForever;
  }
}

extension ListExt<T> on List<T> {
  List<T> takeRandom(int count) {
    final random = Random();
    final shuffledItems = List.of(this)..shuffle(random);
    return shuffledItems.take(count).toList();
  }
}