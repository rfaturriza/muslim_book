import 'package:dartz/dartz.dart';
import 'package:quranku/features/kajian/data/models/mosques_response_model.codegen.dart';
import 'package:quranku/features/kajian/data/models/ramadhan_schedules_response_model.codegen.dart';
import 'package:quranku/features/kajian/domain/entities/kajian_schedule.codegen.dart';
import 'package:quranku/features/kajian/domain/entities/ramadhan_schedules.codegen.dart';

import '../../../../core/error/failures.dart';
import '../models/kajian_schedule_request_model.codegen.dart';
import '../models/ramadhan_schedule_request_model.codegen.dart';

abstract class KajianHubRepository {
  Future<Either<Failure, KajianSchedules>> getKajianList({
    required KajianScheduleRequestModel request,
  });

  Future<Either<Failure, DataKajianSchedule>> getKajianScheduleById({
    required String id,
    String? relations,
  });

  Future<Either<Failure, KajianSchedules>> getNearbyKajianList({
    required double latitude,
    required double longitude,
  });

  Future<Either<Failure, DataRamadhanScheduleModel?>>
      getRamadhanSchedulesByMosque({
    required RamadhanScheduleByMosqueRequestModel request,
  });

  Future<Either<Failure, RamadhanSchedules>> getRamadhanSchedules({
    required RamadhanScheduleRequestModel request,
  });

  Future<Either<Failure, List<DataMosqueModel>>> getMosqueList({
    String? type,
    String? orderBy,
    String? sortBy,
  });

  Future<Either<Failure, List<Province>>> getProvincesList({
    String? type,
    String? orderBy,
    String? sortBy,
    String? relations,
  });

  Future<Either<Failure, List<City>>> getCitiesList({
    String? type,
    String? orderBy,
    String? sortBy,
    String? relations,
  });

  Future<Either<Failure, List<Ustadz>>> getUstadzList({
    String? type,
    String? orderBy,
    String? sortBy,
  });

  Future<Either<Failure, List<KajianTheme>>> getKajianThemesList({
    String? type,
    String? orderBy,
    String? sortBy,
  });
}
