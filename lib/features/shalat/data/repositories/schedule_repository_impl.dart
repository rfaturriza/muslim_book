import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/entities/schedule.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../dataSources/remote/shalat_remote_data_source.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ShalatRemoteDataSource remoteDataSource;

  const ScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ScheduleByDay?>> getScheduleByDay(
      String cityId, int day) async {
    final result = await remoteDataSource.getShalatScheduleByDay(cityId, day);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.dataByDay?.toEntity(),
      ),
    );
  }

  @override
  Future<Either<Failure, ScheduleByMonth?>> getScheduleByMonth(
      String cityId, String month) async {
    final result =
        await remoteDataSource.getShalatScheduleByMonth(cityId, month);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.dataByMonth?.toEntity(),
      ),
    );
  }
}
