import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/entities/geolocation.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../generated/locale_keys.g.dart';
import '../entities/schedule.codegen.dart';

@injectable
class GetCurrentLocationUseCase
    extends UseCase<GeoLocation, GetCurrentLocationParams> {
  @override
  Future<Either<Failure, GeoLocation?>> call(
      GetCurrentLocationParams params) async {
    try {
      final result = await _determinePosition(locale: params.locale);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  Future<GeoLocation> _determinePosition({
    required Locale locale,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(LocaleKeys.errorLocationDisabled.tr());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(LocaleKeys.errorLocationDenied.tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(LocaleKeys.errorLocationPermanentDenied.tr());
    }
    final resultLocator = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(
      resultLocator.latitude,
      resultLocator.longitude,
    );

    return GeoLocation(
      cities: placemarks.map((e) => e.administrativeArea).toList(),
      regions: placemarks.map((e) => e.subAdministrativeArea).toList(),
      country: placemarks.first.country,
      coordinate: Coordinate(
          lat: resultLocator.latitude,
          lon: resultLocator.longitude,
          latitude: resultLocator.latitude.toString(),
          longitude: resultLocator.longitude.toString()),
      url:
          "https://www.google.com/maps/search/?api=1&query=${resultLocator.latitude},${resultLocator.longitude}",
    );
  }
}

class GetCurrentLocationParams extends Equatable {
  final Locale locale;

  const GetCurrentLocationParams({required this.locale});

  @override
  List<Object?> get props => [locale];
}
