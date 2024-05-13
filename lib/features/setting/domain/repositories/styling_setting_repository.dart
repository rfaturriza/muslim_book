import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/last_read_reminder_mode_entity.dart';

abstract class StylingSettingRepository {
  Future<Either<Failure, Unit>> setArabicFontFamily(
    String fontFamily,
  );

  Future<Either<Failure, String?>> getArabicFontFamily();

  Future<Either<Failure, Unit>> setArabicFontSize(
    double fontSize,
  );

  Future<Either<Failure, double?>> getArabicFontSize();

  Future<Either<Failure, Unit>> setLatinFontSize(double fontSize,);

  Future<Either<Failure, double?>> getLatinFontSize();

  Future<Either<Failure, Unit>> setTranslationFontSize(double fontSize,);

  Future<Either<Failure, double?>> getTranslationFontSize();

  Future<Either<Failure, Unit>> setLastReadReminder(LastReadReminderModes mode);

  Future<Either<Failure, LastReadReminderModes>> getLastReadReminder();

  Future<Either<Failure, Unit>> setShowLatin(bool isShow,);

  Future<Either<Failure, bool?>> getShowLatin();

  Future<Either<Failure, Unit>> setShowTranslation(bool isShow,);

  Future<Either<Failure, bool?>> getShowTranslation();
}
