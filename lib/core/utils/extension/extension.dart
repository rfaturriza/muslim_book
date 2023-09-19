import 'package:geolocator/geolocator.dart';

extension LocationPermissionExt on LocationPermission? {
  bool get isGranted {
    return this == LocationPermission.always || this == LocationPermission.whileInUse;
  }

  bool get isNotGranted {
    return this == LocationPermission.denied || this == LocationPermission.deniedForever;
  }
}