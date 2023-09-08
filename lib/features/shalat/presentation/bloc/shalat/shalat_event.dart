part of 'shalat_bloc.dart';

abstract class ShalatEvent extends Equatable {
  const ShalatEvent();

  @override
  List<Object?> get props => [];
}

class GetShalatCityIdByCityEvent extends ShalatEvent {
  final String city;

  const GetShalatCityIdByCityEvent({
    required this.city,
  });

  @override
  List<Object?> get props => [city];
}

class GetShalatScheduleByDayEvent extends ShalatEvent {
  final int? day;

  const GetShalatScheduleByDayEvent({
    this.day,
  });

  @override
  List<Object?> get props => [day];
}

class GetShalatScheduleByMonthEvent extends ShalatEvent {
  final String cityID;
  final int month;

  const GetShalatScheduleByMonthEvent({
    required this.cityID,
    required this.month,
  });

  @override
  List<Object?> get props => [cityID, month];
}
