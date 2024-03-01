import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/last_read_juz.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class SetLastReadJuzUseCase
    implements UseCase<Unit, SetLastReadJuzUseCaseParams> {
  final QuranRepository repository;

  SetLastReadJuzUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SetLastReadJuzUseCaseParams params) async {
    final result = await repository.setLastReadJuz(params.juz);
    return result;
  }
}

class SetLastReadJuzUseCaseParams extends Equatable {
  final LastReadJuz juz;

  const SetLastReadJuzUseCaseParams({required this.juz});

  @override
  List<Object?> get props => [juz];
}
