part of 'qibla_bloc.dart';

@freezed
class QiblaState with _$QiblaState {
  const factory QiblaState({
    Either<Failure, LocationStatus>? locationStatusResult,
    @Default(false) bool isLoading,
    Either<Failure, QiblahDirection>? qiblaDirectionResult,
  }) = _QiblaState;
}
