import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/repositories/schedule_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.codegen.dart';

@injectable
class GetShalatScheduleByMonthUseCase implements UseCase<ScheduleByMonth?, GetShalatScheduleByMonthParams> {
  final ScheduleRepository repository;

  GetShalatScheduleByMonthUseCase(this.repository);

  @override
  Future<Either<Failure, ScheduleByMonth?>> call(GetShalatScheduleByMonthParams params) async {
    return await repository.getScheduleByMonth(params.city, params.month.toString());
  }
}

class GetShalatScheduleByMonthParams extends Equatable {
  final String city;
  final int month;

  const GetShalatScheduleByMonthParams({required this.city, required this.month});

  @override
  List<Object?> get props => [city, month];
}
