import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/language_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetQuranLanguageSetting
    extends UseCase<void, SetQuranLanguageSettingParams> {
  final LanguageSettingRepository repository;

  SetQuranLanguageSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(
      SetQuranLanguageSettingParams params) async {
    return await repository.setQuranLanguageSetting(params.locale);
  }
}

class SetQuranLanguageSettingParams extends Equatable {
  final Locale locale;

  const SetQuranLanguageSettingParams({required this.locale});

  @override
  List<Object?> get props => [locale];
}
