import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/core/utils/pair.dart';

part 'filter_kajian_schedule.codegen.freezed.dart';

@freezed
class FilterKajianSchedule with _$FilterKajianSchedule {
  const factory FilterKajianSchedule({
    Pair<String, String>? studyLocationProvinceId,
    Pair<String, String>? studyLocationCityId,
    Pair<String, String>? locationId,

    /// can multiple day id
    Pair<String, String>? dailySchedulesDayId,

    /// can multiple week id
    Pair<String, String>? weeklySchedulesWeekId,
    Pair<String, String>? prayerSchedule,

    /// can multiple theme id
    Pair<String, String>? themesThemeId,

    /// can multiple ustadz id
    Pair<String, String>? ustadzUstadzId,
  }) = _FilterKajianSchedule;

  const FilterKajianSchedule._();

  bool get isFilterThemeMultiple {
    return (themesThemeId?.first.contains('|') ?? false) &&
        (themesThemeId?.second.contains('|') ?? false);
  }

  bool get isFilterUstadzMultiple {
    return (ustadzUstadzId?.first.contains('|') ?? false) &&
        (ustadzUstadzId?.second.contains('|') ?? false);
  }

  bool get isFilterLocationMultiple {
    return (locationId?.first.contains('|') ?? false) &&
        (locationId?.second.contains('|') ?? false);
  }

  bool get isdailySchedulesDayIdMultiple {
    return (dailySchedulesDayId?.first.contains('|') ?? false) &&
        (dailySchedulesDayId?.second.contains('|') ?? false);
  }

  bool get isweeklySchedulesWeekIdMultiple {
    return (weeklySchedulesWeekId?.first.contains('|') ?? false) &&
        (weeklySchedulesWeekId?.second.contains('|') ?? false);
  }

  bool get isprayerScheduleMultiple {
    return (prayerSchedule?.first.contains('|') ?? false) &&
        (prayerSchedule?.second.contains('|') ?? false);
  }

  bool get isstudyLocationProvinceIdMultiple {
    return (studyLocationProvinceId?.first.contains('|') ?? false) &&
        (studyLocationProvinceId?.second.contains('|') ?? false);
  }

  bool get isstudyLocationCityIdMultiple {
    return (studyLocationCityId?.first.contains('|') ?? false) &&
        (studyLocationCityId?.second.contains('|') ?? false);
  }

  bool get islocationIdMultiple {
    return (locationId?.first.contains('|') ?? false) &&
        (locationId?.second.contains('|') ?? false);
  }
}
