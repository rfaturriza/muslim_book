import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class DeleteLastReadSurahUseCase implements UseCase<Unit, DateTime> {
  final QuranRepository repository;

  DeleteLastReadSurahUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DateTime params) async {
    final result = await repository.deleteLastReadSurah(params);
    return result;
  }
}
