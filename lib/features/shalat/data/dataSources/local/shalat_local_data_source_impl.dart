import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/constants/hive_constants.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/features/shalat/data/dataSources/local/shalat_local_data_source.dart';
import 'package:quranku/features/shalat/data/models/prayer_schedule_setting_model.codegen.dart';

import '../../../domain/entities/geolocation.codegen.dart';

@LazySingleton(as: ShalatLocalDataSource)
class ShalatLocalDataSourceImpl implements ShalatLocalDataSource {
  final HiveInterface hive;

  ShalatLocalDataSourceImpl({
    required this.hive,
  });

  @override
  Future<Either<Failure, PrayerScheduleSettingModel?>>
      getPrayerScheduleSetting() async {
    try {
      var box = await hive.openBox(HiveConst.prayerAlarmScheduleBox);
      final model = box.get(0);
      if (model == null) {
        final alarm = Prayer.values
            .map((e) => PrayerAlarmModel(
                  prayer: e.name,
                  isAlarmActive: false,
                ))
            .toList();
        await box.put(0, PrayerScheduleSettingModel(alarms: alarm));
        return right(PrayerScheduleSettingModel(alarms: alarm));
      }
      return right(model);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> setPrayerScheduleSetting(
    PrayerScheduleSettingModel? model,
  ) async {
    try {
      var box = await hive.openBox(HiveConst.prayerAlarmScheduleBox);
      await box.put(0, model);
      return right(unit);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> setPrayerLocationManual(
    GeoLocation? model,
  ) async {
    try {
      var box = await hive.openBox(HiveConst.settingBox);
      await box.put(HiveConst.locationPrayerKey, model);
      return right(unit);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, GeoLocation?>> getPrayerLocationManual() async {
    try {
      var box = await hive.openBox(HiveConst.settingBox);
      final model = box.get(HiveConst.locationPrayerKey) as GeoLocation?;
      return right(model);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
