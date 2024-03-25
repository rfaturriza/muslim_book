import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/ramadhan_schedules.codegen.dart';
import 'kajian_schedules_response_model.codegen.dart';

part 'ramadhan_schedules_response_model.codegen.freezed.dart';
part 'ramadhan_schedules_response_model.codegen.g.dart';

@freezed
class RamadhanSchedulesByMosqueResponseModel
    with _$RamadhanSchedulesByMosqueResponseModel {
  const factory RamadhanSchedulesByMosqueResponseModel({
    String? prayDate,
    DataRamadhanScheduleModel? data,
  }) = _RamadhanSchedulesByMosqueResponseModel;

  factory RamadhanSchedulesByMosqueResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$RamadhanSchedulesByMosqueResponseModelFromJson(json);
}

@freezed
class RamadhanSchedulesResponseModel with _$RamadhanSchedulesResponseModel {
  const factory RamadhanSchedulesResponseModel({
    List<RamadhanScheduleModel>? data,
    LinksKajianScheduleModel? links,
    MetaKajianScheduleModel? meta,
  }) = _RamadhanSchedulesResponseModel;

  const RamadhanSchedulesResponseModel._();

  factory RamadhanSchedulesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RamadhanSchedulesResponseModelFromJson(json);

  RamadhanSchedules toEntity() {
    return RamadhanSchedules(
      data: data?.map((e) => e.toEntity()).toList() ?? [],
      links: links?.toEntity() ?? LinksKajianScheduleModel.empty().toEntity(),
      meta: meta?.toEntity() ?? MetaKajianScheduleModel.empty().toEntity(),
    );
  }
}

@freezed
class DataRamadhanScheduleModel with _$DataRamadhanScheduleModel {
  const factory DataRamadhanScheduleModel({
    StudyLocationModel? studyLocation,
    List<RamadhanScheduleModel>? schedules,
  }) = _DataRamadhanScheduleModel;

  factory DataRamadhanScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$DataRamadhanScheduleModelFromJson(json);
}

@freezed
class RamadhanScheduleModel with _$RamadhanScheduleModel {
  const factory RamadhanScheduleModel({
    int? id,
    @JsonKey(name: 'pray_date') String? prayDate,
    @JsonKey(name: 'location_id') String? locationId,
    @JsonKey(name: 'type_id') String? typeId,
    @JsonKey(name: 'type_label') String? typeLabel,
    @JsonKey(name: 'subtype_id') String? subtypeId,
    @JsonKey(name: 'subtype_label') String? subtypeLabel,
    String? bilal,
    String? khatib,
    String? imam,
    String? link,
    StudyLocationModel? studyLocation,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'updated_by') String? updatedBy,
    @JsonKey(name: 'deleted_by') String? deletedBy,
  }) = _RamadhanScheduleModel;

  const RamadhanScheduleModel._();

  factory RamadhanScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$RamadhanScheduleModelFromJson(json);

  RamadhanSchedule toEntity() {
    return RamadhanSchedule(
      id: id,
      prayDate: prayDate,
      locationId: locationId,
      typeId: typeId,
      typeLabel: typeLabel,
      subtypeId: subtypeId,
      subtypeLabel: subtypeLabel,
      bilal: bilal,
      khatib: khatib,
      imam: imam,
      link: link,
      studyLocation: studyLocation?.toEntity(),
    );
  }
}
