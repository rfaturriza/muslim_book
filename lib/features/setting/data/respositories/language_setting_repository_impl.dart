import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/language_setting_repository.dart';
import '../datasources/local/language/language_setting_local_data_source.dart';

@LazySingleton(as: LanguageSettingRepository)
class LanguageSettingRepositoryImpl implements LanguageSettingRepository {
  final LanguageSettingLocalDataSource localDataSource;

  const LanguageSettingRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Locale?>> getQuranLanguageSetting() async {
    final result = await localDataSource.getQuranLanguageSetting();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setQuranLanguageSetting(
    Locale locale,
  ) async {
    final result = await localDataSource.setQuranLanguageSetting(locale);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Locale?>> getLatinLanguageSetting() async {
    final result = await localDataSource.getLatinLanguageSetting();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setLatinLanguageSetting(
    Locale locale,
  ) async {
    final result = await localDataSource.setLatinLanguageSetting(locale);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Locale?>> getPrayerLanguageSetting() async {
    final result = await localDataSource.getPrayerLanguageSetting();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setPrayerLanguageSetting(
    Locale locale,
  ) async {
    final result = await localDataSource.setPrayerLanguageSetting(locale);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
