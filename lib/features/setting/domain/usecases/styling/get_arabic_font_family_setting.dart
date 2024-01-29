import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class GetArabicFontFamilySetting extends UseCase<String?, NoParams> {
  final StylingSettingRepository repository;

  GetArabicFontFamilySetting(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await repository.getArabicFontFamily();
  }
}
