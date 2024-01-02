import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/hive_constants.dart';
import '../../../../../core/error/failures.dart';
import 'language_setting_local_data_source.dart';

@LazySingleton(as: LanguageSettingLocalDataSource)
class LanguageSettingLocalDataSourceImpl
    implements LanguageSettingLocalDataSource {
  final HiveInterface hive;

  LanguageSettingLocalDataSourceImpl({
    required this.hive,
  });

  @override
  Future<Either<Failure, Locale>> getLatinLanguageSetting() async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = await box.get(HiveConst.latinLanguageKey);
      final localeSplit = localeString.split('_');
      final result = Locale(localeSplit[0], localeSplit[1]);
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Locale>> getPrayerLanguageSetting() async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = await box.get(HiveConst.prayerTimeLanguageKey);
      final localeSplit = localeString.split('_');
      final result = Locale(localeSplit[0], localeSplit[1]);
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Locale>> getQuranLanguageSetting() async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = await box.get(HiveConst.quranLanguageKey);
      final localeSplit = localeString.split('_');
      final result = Locale(localeSplit[0], localeSplit[1]);
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> setLatinLanguageSetting(Locale locale) async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = '${locale.languageCode}_${locale.countryCode}';
      await box.put(HiveConst.latinLanguageKey, localeString);
      return right(unit);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> setPrayerLanguageSetting(Locale locale) async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = '${locale.languageCode}_${locale.countryCode}';
      await box.put(HiveConst.prayerTimeLanguageKey, localeString);
      return right(unit);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> setQuranLanguageSetting(Locale locale) async {
    try {
      var box = await hive.openBox(HiveConst.languageBox);
      final localeString = '${locale.languageCode}_${locale.countryCode}';
      await box.put(HiveConst.quranLanguageKey, localeString);
      return right(unit);
    } catch (e) {
      return left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
