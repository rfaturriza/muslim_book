import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/shalat/data/models/prayer_schedule_setting_model.codegen.dart';
import 'package:quranku/features/shalat/domain/entities/geolocation.codegen.dart';
import 'package:quranku/features/shalat/domain/entities/prayer_schedule_setting.codegen.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/utils/local_notification.dart';
import '../../domain/repositories/prayer_alarm_repository.dart';
import '../dataSources/local/shalat_local_data_source.dart';

@LazySingleton(as: PrayerAlarmRepository)
class PrayerAlarmRepositoryImpl implements PrayerAlarmRepository {
  final ShalatLocalDataSource localDataSource;
  final LocalNotification localNotification;

  const PrayerAlarmRepositoryImpl(
      {required this.localDataSource, required this.localNotification});

  @override
  Future<Either<Failure, PrayerScheduleSetting?>>
      getPrayerAlarmSchedule() async {
    final result = await localDataSource.getPrayerScheduleSetting();
    return result.fold((error) => left(error), (r) => right(r?.toEntity()));
  }

  @override
  Future<Either<Failure, GeoLocation?>> getPrayerLocationManual() async {
    final result = await localDataSource.getPrayerLocationManual();
    return result;
  }

  @override
  Future<Either<Failure, Unit>> setPrayerAlarmSchedule(
    PrayerScheduleSetting? model,
  ) async {
    final result = await localDataSource.setPrayerScheduleSetting(
      PrayerScheduleSettingModel.fromEntity(model),
    );
    return result;
  }

  @override
  Future<Either<Failure, Unit>> setPrayerLocationManual(
    GeoLocation? location,
  ) async {
    final result = await localDataSource.setPrayerLocationManual(location);
    return result.fold((error) => left(error), (r) => right(r));
  }

  @override
  Future<Either<Failure, Unit>> schedulePrayerAlarm() async {
    final result = await localDataSource.getPrayerScheduleSetting();
    if (result.isLeft()) {
      return left(result.asLeft());
    }
    final entity = result.asRight()?.toEntity();
    final alarms = entity?.alarms;

    alarms?.forEach((element) async {
      if (element.time == null) return;
      await localNotification.schedulePeriodically(
        id: element.prayer?.index ?? 0,
        title: LocaleKeys.notificationPrayerTitle.tr(namedArgs: {
          'prayer': element.prayer?.name.capitalizeEveryWord() ?? '',
          'time': TimeOfDay.fromDateTime(element.time!).toString(),
        }),
        body: LocaleKeys.notificationPrayerDescription.tr(
          namedArgs: {
            'location': entity?.location ?? '',
          },
        ),
        timeOfDay: TimeOfDay.fromDateTime(element.time!),
      );
    });
    return right(unit);
  }
}
