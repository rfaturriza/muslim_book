import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/last_read_juz.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetLastReadJuzUseCase implements UseCase<List<LastReadJuz>?, NoParams> {
  final QuranRepository repository;

  GetLastReadJuzUseCase(this.repository);

  @override
  Future<Either<Failure, List<LastReadJuz>?>> call(NoParams params) async {
    final result = await repository.getLastReadJuz();
    return result;
  }
}
