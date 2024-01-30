import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/language_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class GetQuranLanguageSetting extends UseCase<Locale?, NoParams> {
  final LanguageSettingRepository repository;

  GetQuranLanguageSetting(this.repository);

  @override
  Future<Either<Failure, Locale?>> call(NoParams params) async {
    return await repository.getQuranLanguageSetting();
  }
}
