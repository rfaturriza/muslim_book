import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/surah.codegen.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetListSurahUseCase implements UseCase<List<Surah>?, NoParams> {
  final QuranRepository repository;

  GetListSurahUseCase(this.repository);

  @override
  Future<Either<Failure, List<Surah>?>> call(NoParams params) async {
    final resultCache = await repository.getCacheAllSurah();

    if (resultCache.isRight() && resultCache.asRight()?.isNotEmpty == true) {
      return resultCache;
    }

    final resultApi = await repository.getListOfSurah();

    if (resultApi.isRight() && resultApi.asRight() != null) {
      await repository.setCacheAllSurah(resultApi.asRight()!);
    }

    return resultApi;
  }
}
