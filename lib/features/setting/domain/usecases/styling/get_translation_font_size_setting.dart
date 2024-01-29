import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class GetTranslationFontSizeSetting extends UseCase<double?, NoParams> {
  final StylingSettingRepository repository;

  GetTranslationFontSizeSetting(this.repository);

  @override
  Future<Either<Failure, double?>> call(NoParams params) async {
    return await repository.getTranslationFontSize();
  }
}
