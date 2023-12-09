import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_juz.codegen.dart';
import '../entities/detail_surah.codegen.dart';
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
}
