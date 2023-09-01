import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/surah.codegen.dart';
import '../repositories/quran_repository.dart';

@injectable
class GetListSurahUseCase implements UseCase<List<Surah>?, NoParams> {
  final QuranRepository repository;

  GetListSurahUseCase(this.repository);

  @override
  Future<Either<Failure, List<Surah>?>> call(NoParams params) async {
    return await repository.getListOfSurah();
  }
}
