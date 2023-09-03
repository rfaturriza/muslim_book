import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/verse_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class GetListVersesBookmarkUseCase
    extends UseCase<List<VerseBookmark>, NoParams> {
  final BookmarkRepository repository;

  GetListVersesBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, List<VerseBookmark>>> call(NoParams params) async {
    return await repository.getListVersesBookmark();
  }
}
