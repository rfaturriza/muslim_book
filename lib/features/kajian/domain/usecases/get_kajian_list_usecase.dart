import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/models/kajian_schedule_request_model.codegen.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kajian_schedule.codegen.dart';

@injectable
class GetKajianListUseCase
    implements UseCase<KajianSchedules, KajianScheduleRequestModel> {
  final KajianHubRepository repository;

  GetKajianListUseCase(this.repository);

  @override
  Future<Either<Failure, KajianSchedules>> call(
    KajianScheduleRequestModel params,
  ) async {
    final result = await repository.getKajianList(request: params);
    return result;
  }
}
