part of 'prayer_schedule_bloc.dart';

@freezed
class PrayerScheduleEvent with _$PrayerScheduleEvent {
  const factory PrayerScheduleEvent.fetchRamadhanSchedules({
    required Locale locale,
    required int pageNumber,
  }) = _FetchRamadhanSchedules;

  const factory PrayerScheduleEvent.toggleNearby() = _ToggleNearby;
}
