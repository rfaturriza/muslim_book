import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/detail_juz.codegen.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetDetailJuzUseCase implements UseCase<DetailJuz?, Params> {
  final QuranRepository repository;

  GetDetailJuzUseCase(this.repository);

  @override
  Future<Either<Failure, DetailJuz?>> call(Params params) async {
    final resultCache = await repository.getCacheDetailJuz(params.number);

    if (resultCache.isRight() && resultCache.asRight() != null) {
      return resultCache;
    }

    final resultApi = await repository.getDetailJuz(params.number);

    if (resultApi.isRight() && resultApi.asRight() != null) {
      await repository.setCacheDetailJuz(resultApi.asRight()!);
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
