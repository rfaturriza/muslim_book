import 'package:dartz/dartz.dart';
import 'package:quranku/features/quran/data/models/detail_juz_model.codegen.dart';
import 'package:quranku/features/quran/data/models/detail_surah_model.codegen.dart';
import 'package:quranku/features/quran/data/models/last_read_surah_model.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../models/last_read_juz_model.codegen.dart';
import '../../models/surah_model.codegen.dart';

abstract class QuranLocalDataSource {
  Future<Either<Failure, Unit>> setAllSurah(List<DataSurahModel> surah);

  Future<Either<Failure, List<DataSurahModel>>> getAllSurah();

  Future<Either<Failure, Unit>> setDetailSurah(DataDetailSurahModel surah);

  Future<Either<Failure, DataDetailSurahModel>> getDetailSurah(int surahNumber);

  Future<Either<Failure, Unit>> setDetailJuz(DataDetailJuzModel juz);

  Future<Either<Failure, DataDetailJuzModel>> getDetailJuz(int juzNumber);

  Future<Either<Failure, Unit>> setLastReadSurah(LastReadSurahModel surah);

  Future<Either<Failure, List<LastReadSurahModel>>> getLastReadSurah();

  Future<Either<Failure, Unit>> setLastReadJuz(LastReadJuzModel juz);

  Future<Either<Failure, List<LastReadJuzModel>>> getLastReadJuz();

  Future<Either<Failure, Unit>> deleteLastReadSurah(DateTime createdAt);

  Future<Either<Failure, Unit>> deleteLastReadJuz(DateTime createdAt);

  Future<Either<Failure, Unit>> deleteAllLastReadSurah();

  Future<Either<Failure, Unit>> deleteAllLastReadJuz();
}
