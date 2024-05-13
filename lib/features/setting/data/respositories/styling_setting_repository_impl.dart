import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/data/datasources/local/styling/styling_setting_local_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/last_read_reminder_mode_entity.dart';
import '../../domain/repositories/styling_setting_repository.dart';

@LazySingleton(as: StylingSettingRepository)
class StylingSettingRepositoryImpl implements StylingSettingRepository {
  final StylingSettingLocalDataSource localDataSource;

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

  @override
  Future<Either<Failure, LastReadReminderModes>> getLastReadReminder() async {
    final result = await localDataSource.getLastReadReminder();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, bool?>> getShowLatin() async {
    final result = await localDataSource.getShowLatin();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, bool?>> getShowTranslation() async {
    final result = await localDataSource.getShowTranslation();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setLastReadReminder(LastReadReminderModes mode) async {
    final result = await localDataSource.setLastReadReminder(mode);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setShowLatin(bool isShow) async {
    final result = await localDataSource.setShowLatin(isShow);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setShowTranslation(bool isShow) async {
    final result = await localDataSource.setShowTranslation(isShow);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
