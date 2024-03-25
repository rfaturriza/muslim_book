import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/core/utils/pair.dart';

part 'filter_prayer_schedule.codegen.freezed.dart';

@freezed
class FilterPrayerSchedule with _$FilterPrayerSchedule {
  const factory FilterPrayerSchedule({
    Pair<String, String>? studyLocationProvinceId,
    Pair<String, String>? studyLocationCityId,
    Pair<String, String>? locationId,

    Pair<String, String>? prayerSchedule,

    DateTime? prayDate,
    String? imam,
    String? khatib,
    @Default(false) bool isNearby,
  }) = _FilterPrayerSchedule;

  const FilterPrayerSchedule._();

  bool isEmpty() {
    return this == const FilterPrayerSchedule();
  }

  bool isNotEmpty() {
    return this != const FilterPrayerSchedule();
  }
}
