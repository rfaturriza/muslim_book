import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quran_repository.dart';

@injectable
class DeleteLastReadJuzUseCase implements UseCase<Unit, DateTime> {
  final QuranRepository repository;

  DeleteLastReadJuzUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DateTime params) async {
    final result = await repository.deleteLastReadJuz(params);
    return result;
  }
}
