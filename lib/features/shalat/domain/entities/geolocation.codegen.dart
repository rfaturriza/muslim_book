import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/features/shalat/domain/entities/schedule.codegen.dart';

part 'geolocation.codegen.freezed.dart';

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    String? city,
    String? region,
    String? country,
    Coordinate? coordinate,
    String? url,
  }) = _GeoLocation;
}
