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

  @override
  Future<Either<Failure, String?>> getArabicFontFamily() async {
    final result = await localDataSource.getArabicFontFamily();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, double?>> getArabicFontSize() async {
    final result = await localDataSource.getArabicFontSize();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, double?>> getLatinFontSize() async {
    final result = await localDataSource.getLatinFontSize();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, double?>> getTranslationFontSize() async {
    final result = await localDataSource.getTranslationFontSize();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setArabicFontFamily(String fontFamily) async {
    final result = await localDataSource.setArabicFontFamily(fontFamily);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setArabicFontSize(double fontSize) async {
    final result = await localDataSource.setArabicFontSize(fontSize);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setLatinFontSize(double fontSize) async {
    final result = await localDataSource.setLatinFontSize(fontSize);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setTranslationFontSize(double fontSize) async {
    final result = await localDataSource.setTranslationFontSize(fontSize);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
