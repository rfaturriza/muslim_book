import 'package:freezed_annotation/freezed_annotation.dart';

part 'kajian_schedule_response_model.codegen.freezed.dart';
part 'kajian_schedule_response_model.codegen.g.dart';

@freezed
class KajianScheduleResponseModel with _$KajianScheduleResponseModel {
  const factory KajianScheduleResponseModel({
    required List<DataKajianScheduleModel> data,
    required LinksKajianScheduleModel links,
    required MetaKajianScheduleModel meta,
  }) = _KajianScheduleResponseModel;

  factory KajianScheduleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$KajianScheduleResponseModelFromJson(json);
}

@freezed
class DataKajianScheduleModel with _$DataKajianScheduleModel {
  const factory DataKajianScheduleModel({
    required int id,
    required String title,
    required String type,
    required String typeLabel,
    required String book,
    required String timeStart,
    required String timeEnd,
    @JsonKey(name: 'jadwal_shalat') required String prayerSchedule,
    required String locationId,
    required String createdAt,
    required String updatedAt,
    required String? deletedAt,
    required String createdBy,
    required String updatedBy,
    required String? deletedBy,
  }) = _DataKajianScheduleModel;

  factory DataKajianScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$DataKajianScheduleModelFromJson(json);
}

@freezed
class LinksKajianScheduleModel with _$LinksKajianScheduleModel {
  const factory LinksKajianScheduleModel({
    required String first,
    required String last,
    required String? prev,
    required String? next,
  }) = _LinksKajianScheduleModel;

  factory LinksKajianScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$LinksKajianScheduleModelFromJson(json);
}

@freezed
class MetaKajianScheduleModel with _$MetaKajianScheduleModel {
  const factory MetaKajianScheduleModel({
    required int currentPage,
    required int from,
    required int lastPage,
    required List<LinksMeta> links,
    required String path,
    required int perPage,
    required int to,
    required int total,
  }) = _MetaKajianScheduleModel;

  factory MetaKajianScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$MetaKajianScheduleModelFromJson(json);
}

@freezed
class LinksMeta with _$LinksMeta {
  const factory LinksMeta({
    required String? url,
    required String label,
    required bool active,
  }) = _LinksMeta;

  factory LinksMeta.fromJson(Map<String, dynamic> json) =>
      _$LinksMetaFromJson(json);
}
