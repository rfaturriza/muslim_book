part of 'shalat_bloc.dart';

@freezed
class ShalatState with _$ShalatState {
  const factory ShalatState({
    Either<Failure, ShalatLocation?>? location,
    Either<Failure, ScheduleByDay?>? scheduleByDay,
    Either<Failure, ScheduleByMonth?>? scheduleByMonth,
    GeoLocation? geoLocation,
    @Default(false) bool isLoading,
  }) = _ShalatState;
}
