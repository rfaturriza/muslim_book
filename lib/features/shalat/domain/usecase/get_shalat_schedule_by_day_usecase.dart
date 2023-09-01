import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/repositories/schedule_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.codegen.dart';

@injectable
class GetShalatScheduleByDayUseCase
    implements UseCase<ScheduleByDay?, GetShalatScheduleByDayParams> {
  final ScheduleRepository repository;

  GetShalatScheduleByDayUseCase(this.repository);

  @override
  Future<Either<Failure, ScheduleByDay?>> call(
      GetShalatScheduleByDayParams params) async {
    return await repository.getScheduleByDay(params.cityID, params.day);
  }
}

class GetShalatScheduleByDayParams extends Equatable {
  final String cityID;
  final int day;

  const GetShalatScheduleByDayParams({required this.cityID, required this.day});

  @override
  List<Object?> get props => [cityID, day];
}
