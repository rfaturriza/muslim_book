import 'package:freezed_annotation/freezed_annotation.dart';

import 'kajian_schedule.codegen.dart';

part 'ramadhan_schedules.codegen.freezed.dart';

@freezed
class RamadhanSchedules with _$RamadhanSchedules {
  const factory RamadhanSchedules({
    required List<RamadhanSchedule> data,
    required LinksKajianSchedule links,
    required MetaKajianSchedule meta,
  }) = _RamadhanSchedules;
}

@freezed
class RamadhanSchedule with _$RamadhanSchedule {
  const factory RamadhanSchedule({
    int? id,
    String? prayDate,
    String? locationId,
    String? typeId,
    String? typeLabel,
    String? subtypeId,
    String? subtypeLabel,
    String? bilal,
    String? khatib,
    String? imam,
    String? link,
    StudyLocation? studyLocation,
  }) = _RamadhanSchedule;
}
