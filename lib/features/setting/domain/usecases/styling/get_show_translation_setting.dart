import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class GetShowTranslationSetting extends UseCase<bool?, NoParams> {
  final StylingSettingRepository repository;

  GetShowTranslationSetting(this.repository);

  @override
  Future<Either<Failure, bool?>> call(NoParams params) async {
    return await repository.getShowTranslation();
  }
}
