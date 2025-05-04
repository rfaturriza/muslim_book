import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/repositories/prayer_alarm_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class SchedulePrayerAlarmUseCase extends UseCase<Unit, NoParams?> {
  final PrayerAlarmRepository _repository;

  SchedulePrayerAlarmUseCase(this._repository);

  @override
  Future<Either<Failure, Unit?>> call(
    NoParams? params,
  ) async {
    return _repository.schedulePrayerAlarm();
  }
}
