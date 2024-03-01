import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class DeleteAllLastReadSurahUseCase implements UseCase<Unit, NoParams> {
  final QuranRepository repository;

  DeleteAllLastReadSurahUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final result = await repository.deleteAllLastReadSurah();
    return result;
  }
}
