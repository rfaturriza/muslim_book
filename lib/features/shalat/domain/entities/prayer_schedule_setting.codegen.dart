import 'package:adhan/adhan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/features/shalat/presentation/helper/helper_time_shalat.dart';

part 'prayer_schedule_setting.codegen.freezed.dart';

@freezed
class PrayerScheduleSetting with _$PrayerScheduleSetting {
  const factory PrayerScheduleSetting({
    @Default([]) List<PrayerAlarm> alarms,
    @Default(CalculationMethod.egyptian) CalculationMethod calculationMethod,
    @Default(Madhab.shafi) Madhab madhab,
    @Default('') String location,
  }) = _PrayerScheduleSetting;
}

@freezed
class PrayerAlarm with _$PrayerAlarm {
  const factory PrayerAlarm({
    DateTime? time,
    PrayerInApp? prayer,
    @Default(false) bool isAlarmActive,
  }) = _PrayerAlarm;
}
