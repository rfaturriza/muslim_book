import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetShowTranslationSetting extends UseCase<Unit?, bool> {
  final StylingSettingRepository repository;

  SetShowTranslationSetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(bool params) async {
    return await repository.setShowTranslation(params);
  }
}
