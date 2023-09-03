import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/juz_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class GetListJuzBookmarkUseCase extends UseCase<List<JuzBookmark>, NoParams> {
  final BookmarkRepository repository;

  GetListJuzBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, List<JuzBookmark>>> call(NoParams params) async {
    return await repository.getListJuzBookmark();
  }
}
