part of 'prayer_schedule_bloc.dart';

@freezed
class PrayerScheduleState with _$PrayerScheduleState {
  const factory PrayerScheduleState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default([]) List<RamadhanSchedule> ramadhanSchedules,
    @Default(1) int currentPage,
    int? lastPage,
    int? totalData,
    @Default(true) bool isNearby,
  }) = _PrayerScheduleState;
}
