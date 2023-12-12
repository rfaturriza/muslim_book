import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/shalat/domain/entities/schedule.codegen.dart';

part 'geolocation.codegen.freezed.dart';

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    List<String?>? cities,
    List<String?>? regions,
    String? country,
    Coordinate? coordinate,
    String? url,
  }) = _GeoLocation;

  const GeoLocation._();

  String get city =>
      cities?.firstWhere((city) => city?.isNotEmpty == true,
          orElse: () => emptyString) ??
      emptyString;

  String get region =>
      regions?.firstWhere((region) => region?.isNotEmpty == true,
          orElse: () => emptyString) ??
      emptyString;

  String get place => region == emptyString ? city : '$region, $city';
}
