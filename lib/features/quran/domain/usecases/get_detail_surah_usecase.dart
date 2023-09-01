import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
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
    return await repository.getDetailSurah(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
