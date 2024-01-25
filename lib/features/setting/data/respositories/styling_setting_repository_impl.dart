import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/styling_setting_repository.dart';
import '../datasources/local/language/language_setting_local_data_source.dart';

@LazySingleton(as: StylingSettingRepository)
class StylingSettingRepositoryImpl implements StylingSettingRepository {
  final LanguageSettingLocalDataSource localDataSource;

  const StylingSettingRepositoryImpl({
    required this.localDataSource,
  });

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
