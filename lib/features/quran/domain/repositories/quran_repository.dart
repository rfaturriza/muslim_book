import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_juz.codegen.dart';
import '../entities/detail_surah.codegen.dart';
import '../entities/last_read_juz.codegen.dart';
import '../entities/last_read_surah.codegen.dart';
import '../entities/surah.codegen.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Surah>?>> getListOfSurah();

  Future<Either<Failure, DetailSurah?>> getDetailSurah(int surahNumber);

  Future<Either<Failure, DetailJuz?>> getDetailJuz(int juzNumber);

  Future<Either<Failure, Unit>> setCacheAllSurah(List<Surah> surah);

  Future<Either<Failure, List<Surah>?>> getCacheAllSurah();

  Future<Either<Failure, Unit>> setCacheDetailSurah(DetailSurah surah);

  Future<Either<Failure, DetailSurah?>> getCacheDetailSurah(int surahNumber);

  Future<Either<Failure, Unit>> setCacheDetailJuz(DetailJuz juz);

  Future<Either<Failure, DetailJuz?>> getCacheDetailJuz(int juzNumber);

  Future<Either<Failure, List<LastReadSurah>>> getLastReadSurah();

  Future<Either<Failure, Unit>> setLastReadSurah(LastReadSurah surah);

  Future<Either<Failure, List<LastReadJuz>>> getLastReadJuz();

  Future<Either<Failure, Unit>> setLastReadJuz(LastReadJuz juz);

  Future<Either<Failure, Unit>> deleteLastReadSurah(DateTime createdAt);

  Future<Either<Failure, Unit>> deleteLastReadJuz(DateTime createdAt);

  Future<Either<Failure, Unit>> deleteAllLastReadSurah();

  Future<Either<Failure, Unit>> deleteAllLastReadJuz();
}
