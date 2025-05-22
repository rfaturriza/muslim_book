part of 'shalat_bloc.dart';

@freezed
class ShalatEvent with _$ShalatEvent {
  const factory ShalatEvent.init(
    Locale? locale,
  ) = _Init;

  const factory ShalatEvent.getShalatCityIdByCityEvent({
    required String city,
  }) = GetShalatCityIdByCityEvent;

  const factory ShalatEvent.getShalatScheduleByDayEvent({
    int? day,
  }) = GetShalatScheduleByDayEvent;

  const factory ShalatEvent.getShalatScheduleByMonthEvent({
    required String cityID,
    required int month,
  }) = GetShalatScheduleByMonthEvent;

  const factory ShalatEvent.onChangedLocationStatusEvent({
    LocationStatus? status,
  }) = _OnChangedLocationStatusEvent;

  const factory ShalatEvent.onChangedPermissionDialogEvent(
    bool hasShownPermissionDialog,
  ) =
      _OnChangedPermissionDialogEvent;

  const factory ShalatEvent.getLocationManualEvent() = _GetLocationManualEvent;

  const factory ShalatEvent.setLocationManualEvent({
    required GeoLocation location,
  }) = _SetLocationManualEvent;

  const factory ShalatEvent.getPrayerScheduleSettingEvent() =
      _GetPrayerScheduleSettingEvent;

  const factory ShalatEvent.setPrayerScheduleSettingEvent({
    required PrayerScheduleSetting? model,
  }) = _SetPrayerScheduleSettingEvent;

  const factory ShalatEvent.schedulePrayerAlarmEvent() =
      _SchedulePrayerAlarmEvent;
      
  const factory ShalatEvent.schedulePrayerAlarmWithLocationEvent({
    required GeoLocation location,
    @Default(false) bool forceUpdate,
  }) = _SchedulePrayerAlarmWithLocationEvent;
  
  const factory ShalatEvent.checkAndUpdateNotificationsEvent() =
      _CheckAndUpdateNotificationsEvent;
}
