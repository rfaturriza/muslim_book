import 'package:freezed_annotation/freezed_annotation.dart';

part 'kajian_schedule_request_model.codegen.freezed.dart';
part 'kajian_schedule_request_model.codegen.g.dart';

@freezed
class KajianScheduleRequestModel with _$KajianScheduleRequestModel {
  const factory KajianScheduleRequestModel({
    /// type:pagination/collection
    required String type,

    /// q: search by judul kajian/nama masjid/nama ustad
    @JsonKey(name: 'q') required String query,
    required int page,
    required int limit,
    required String orderBy,
    required String sortBy,

    /// relations: ustadz,studyLocation.province,studyLocation.city,dailySchedules,customSchedules,themes
    /// untuk menampilkan resource relasi
    required String relations,

    /// 0/1 -> 1 = menampilkan kajian berdasarkan jadwal harian dan mingguan
    required int isDaily,

    /// 0/1 -> 1 = menampilkan kajian berdasarkan lokasi anda (terdekat), wajib kirim longitude dan latitude
    required int isNearest,
    required double latitude,
    required double longitude,

    /// 0/1 1 = menampilkan kajian yg tidak rutin, kirim date (defaultnya hari ini)
    required int isByDate,
    required String date,

    /// filter,{relation}.{field},{operator},{value}
    required List<String> options,
  }) = _KajianScheduleRequestModel;

  factory KajianScheduleRequestModel.fromJson(Map<String, dynamic> json) =>
      _$KajianScheduleRequestModelFromJson(json);
}
