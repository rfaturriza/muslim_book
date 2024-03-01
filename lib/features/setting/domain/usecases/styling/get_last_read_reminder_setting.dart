import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class GetLastReadReminderSetting extends UseCase<bool?, NoParams> {
  final StylingSettingRepository repository;

  GetLastReadReminderSetting(this.repository);

  @override
  Future<Either<Failure, bool?>> call(NoParams params) async {
    return await repository.getLastReadReminder();
  }
}
