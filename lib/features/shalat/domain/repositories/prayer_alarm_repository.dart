import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/geolocation.codegen.dart';
import '../entities/prayer_schedule_setting.codegen.dart';

abstract class PrayerAlarmRepository {
  Future<Either<Failure, PrayerScheduleSetting?>> getPrayerAlarmSchedule();

  Future<Either<Failure, Unit>> setPrayerAlarmSchedule(
    PrayerScheduleSetting? model,
  );

  Future<Either<Failure, GeoLocation?>> getPrayerLocationManual();

  Future<Either<Failure, Unit>> setPrayerLocationManual(
    GeoLocation? location,
  );

  Future<Either<Failure, Unit>> schedulePrayerAlarm();
}
