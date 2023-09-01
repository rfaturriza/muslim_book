import 'package:dartz/dartz.dart';
import 'package:quranku/features/shalat/domain/entities/schedule.codegen.dart';

import '../../../../core/error/failures.dart';

abstract class ScheduleRepository {
  Future<Either<Failure,ScheduleByDay?>> getScheduleByDay(String cityId, int day);
  Future<Either<Failure,ScheduleByMonth?>> getScheduleByMonth(String cityId, String month);
}