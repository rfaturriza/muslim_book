import 'package:dartz/dartz.dart';
import 'package:quranku/features/quran/data/models/detail_juz_model.codegen.dart';
import 'package:quranku/features/quran/data/models/detail_surah_model.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../models/surah_model.codegen.dart';

abstract class QuranLocalDataSource {
  Future<Either<Failure, Unit>> setAllSurah(List<DataSurahModel> surah);

  Future<Either<Failure, List<DataSurahModel>>> getAllSurah();

  Future<Either<Failure, Unit>> setDetailSurah(DataDetailSurahModel surah);

  Future<Either<Failure, DataDetailSurahModel>> getDetailSurah(int surahNumber);

  Future<Either<Failure, Unit>> setDetailJuz(DataDetailJuzModel juz);

  Future<Either<Failure, DataDetailJuzModel>> getDetailJuz(int juzNumber);
}
