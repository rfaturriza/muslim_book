import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/language_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetPrayerTimeLanguageSetting
    extends UseCase<void, SetPrayerTimeLanguageSettingParams> {
  final LanguageSettingRepository repository;

  SetPrayerTimeLanguageSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(
      SetPrayerTimeLanguageSettingParams params) async {
    return await repository.setPrayerLanguageSetting(params.locale);
  }
}

class SetPrayerTimeLanguageSettingParams extends Equatable {
  final Locale locale;

  const SetPrayerTimeLanguageSettingParams({required this.locale});

  @override
  List<Object?> get props => [locale];
}
