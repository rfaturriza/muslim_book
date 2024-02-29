import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/last_read_surah.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class SetLastReadSurahUseCase
    implements UseCase<Unit, SetLastReadSurahUseCaseParams> {
  final QuranRepository repository;

  SetLastReadSurahUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      SetLastReadSurahUseCaseParams params) async {
    final result = await repository.setLastReadSurah(params.surah);
    return result;
  }
}

class SetLastReadSurahUseCaseParams extends Equatable {
  final LastReadSurah surah;

  const SetLastReadSurahUseCaseParams({required this.surah});

  @override
  List<Object?> get props => [surah];
}
