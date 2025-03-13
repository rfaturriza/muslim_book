import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/prayer_kajian_schedule_request_model.codegen.dart';
import '../entities/prayer_kajian_schedules.codegen.dart';

@injectable
class GetPrayerKajianSchedulesUseCase
    implements
        UseCase<PrayerkajianSchedules?, PrayerKajianScheduleRequestModel> {
  final KajianHubRepository repository;

  GetPrayerKajianSchedulesUseCase(this.repository);

  @override
  Future<Either<Failure, PrayerkajianSchedules?>> call(
    PrayerKajianScheduleRequestModel request,
  ) async {
    final result = await repository.getPrayerKajianSchedules(request: request);
    return result;
  }
}
