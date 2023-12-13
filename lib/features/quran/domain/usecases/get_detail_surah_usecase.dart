import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/features/quran/domain/entities/detail_surah.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetDetailSurahUseCase implements UseCase<DetailSurah?, Params> {
  final QuranRepository repository;

  GetDetailSurahUseCase(this.repository);

  @override
  Future<Either<Failure, DetailSurah?>> call(Params params) async {
    final resultCache = await repository.getCacheDetailSurah(params.number);

    if (resultCache.isRight() && resultCache.asRight() != null) {
      return resultCache;
    }

    final resultApi = await repository.getDetailSurah(params.number);
    if (resultApi.isRight() && resultApi.asRight() != null) {
      await repository.setCacheDetailSurah(resultApi.asRight()!);
    }
    return resultApi;
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
