import 'dart:ui';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LanguageSettingRepository {
  Future<Either<Failure, Locale?>> getQuranLanguageSetting();

  Future<Either<Failure, Unit>> setQuranLanguageSetting(
    Locale locale,
  );

  Future<Either<Failure, Locale?>> getLatinLanguageSetting();

  Future<Either<Failure, Unit>> setLatinLanguageSetting(
    Locale locale,
  );

  Future<Either<Failure, Locale?>> getPrayerLanguageSetting();

  Future<Either<Failure, Unit>> setPrayerLanguageSetting(
    Locale locale,
  );
}
