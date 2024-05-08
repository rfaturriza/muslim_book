import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/entities/last_read_reminder_mode_entity.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetLastReadReminderSetting extends UseCase<Unit?, LastReadReminderModes> {
  final StylingSettingRepository repository;

  SetLastReadReminderSetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(LastReadReminderModes params) async {
    return await repository.setLastReadReminder(params);
  }
}
