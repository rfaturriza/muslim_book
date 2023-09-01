import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/features/shalat/data/models/schedule_model.codegen.dart';

part 'schedule.codegen.freezed.dart';

@freezed
class ScheduleByDay with _$ScheduleByDay {
  const factory ScheduleByDay({
    String? id,
    String? location,
    String? area,
    Coordinate? coordinate,
    Schedule? schedule,
  }) = _ScheduleByDay;

  const ScheduleByDay._();

  DataScheduleByDayModel toModel() => DataScheduleByDayModel(
    id: id,
    location: location,
    area: area,
    coordinate: coordinate?.toModel(),
    schedule: schedule?.toModel(),
  );
}

@freezed
class ScheduleByMonth with _$ScheduleByMonth {
  const factory ScheduleByMonth({
    String? id,
    String? location,
    String? area,
    Coordinate? coordinate,
    List<Schedule>? schedule,
  }) = _ScheduleByMonth;

  const ScheduleByMonth._();

  DataScheduleByMonthModel toModel() => DataScheduleByMonthModel(
    id: id,
    location: location,
    area: area,
    coordinate: coordinate?.toModel(),
    schedule: schedule?.map((e) => e.toModel()).toList(),
  );
}

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    String? date,
    String? imsak,
    String? subuh,
    String? terbit,
    String? dhuha,
    String? dzuhur,
    String? ashar,
    String? maghrib,
    String? isya,
  }) = _Schedule;

  const Schedule._();

  ScheduleModel toModel() => ScheduleModel(
    date: date,
    imsak: imsak,
    subuh: subuh,
    terbit: terbit,
    dhuha: dhuha,
    dzuhur: dzuhur,
    ashar: ashar,
    maghrib: maghrib,
    isya: isya,
  );
}

@freezed
class Coordinate with _$Coordinate {
  const factory Coordinate({
    double? lat,
    double? lon,
    String? latitude,
    String? longitude,
  }) = _Coordinate;

  const Coordinate._();

  CoordinateModel toModel() => CoordinateModel(
    lat: lat,
    lon: lon,
    latitude: latitude,
    longitude: longitude,
  );
}

