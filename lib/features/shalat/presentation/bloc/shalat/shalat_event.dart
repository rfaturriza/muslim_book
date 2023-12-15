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
}
