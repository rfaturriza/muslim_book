import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/last_read_surah.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetLastReadSurahUseCase
    implements UseCase<List<LastReadSurah>?, NoParams> {
  final QuranRepository repository;

  GetLastReadSurahUseCase(this.repository);

  @override
  Future<Either<Failure, List<LastReadSurah>?>> call(NoParams params) async {
    final result = await repository.getLastReadSurah();
    return result;
  }
}
