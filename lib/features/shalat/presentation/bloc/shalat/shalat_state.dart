part of 'shalat_bloc.dart';

@freezed
class ShalatState with _$ShalatState {
  const factory ShalatState({
    ShalatLocation? location,
    ScheduleByDay? scheduleByDay,
    ScheduleByMonth? schedulesByMonth,
    GeoLocation? geoLocation,
    Failure? failure,
    @Default(false) bool isLoading,
  }) = _ShalatState;
}
