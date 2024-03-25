import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/ramadhan_schedule_request_model.codegen.dart';
import '../entities/ramadhan_schedules.codegen.dart';

@injectable
class GetRamadhanSchedulesUseCase
    implements UseCase<RamadhanSchedules?, RamadhanScheduleRequestModel> {
  final KajianHubRepository repository;

  GetRamadhanSchedulesUseCase(this.repository);

  @override
  Future<Either<Failure, RamadhanSchedules?>> call(
    RamadhanScheduleRequestModel request,
  ) async {
    final result = await repository.getRamadhanSchedules(request: request);
    return result;
  }
}
