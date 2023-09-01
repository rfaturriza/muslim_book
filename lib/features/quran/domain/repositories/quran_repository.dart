import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/detail_juz.codegen.dart';
import '../entities/detail_surah.codegen.dart';
import '../entities/surah.codegen.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Surah>?>> getListOfSurah();

  Future<Either<Failure, DetailSurah?>> getDetailSurah(int surahNumber);

  Future<Either<Failure, DetailJuz?>> getDetailJuz(int juzNumber);
}
