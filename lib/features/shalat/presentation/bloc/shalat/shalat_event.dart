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
  final String city;
  final int day;

  const GetShalatScheduleByDayEvent({
    required this.city,
    required this.day,
  });

  @override
  List<Object?> get props => [city, day];
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
