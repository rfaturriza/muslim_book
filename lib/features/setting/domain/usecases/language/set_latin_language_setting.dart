import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/language_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetLatinLanguageSetting
    extends UseCase<void, SetLatinLanguageSettingParams> {
  final LanguageSettingRepository repository;

  SetLatinLanguageSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(
      SetLatinLanguageSettingParams params) async {
    return await repository.setLatinLanguageSetting(params.locale);
  }
}

class SetLatinLanguageSettingParams extends Equatable {
  final Locale locale;

  const SetLatinLanguageSettingParams({required this.locale});

  @override
  List<Object?> get props => [locale];
}
