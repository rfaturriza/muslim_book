import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';

abstract class StylingSettingLocalDataSource {
  Future<Either<Failure, Unit>> setArabicFontFamily(
    String fontFamily,
  );

  Future<Either<Failure, String?>> getArabicFontFamily();

  Future<Either<Failure, Unit>> setArabicFontSize(
    double fontSize,
  );

  Future<Either<Failure, double?>> getArabicFontSize();

  Future<Either<Failure, Unit>> setLatinFontSize(
    double fontSize,
  );

  Future<Either<Failure, double?>> getLatinFontSize();

  Future<Either<Failure, Unit>> setTranslationFontSize(
    double fontSize,
  );

  Future<Either<Failure, double?>> getTranslationFontSize();
}
