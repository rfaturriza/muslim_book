import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/surah_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class GetListSurahBookmarkUseCase
    extends UseCase<List<SurahBookmark>, NoParams> {
  final BookmarkRepository repository;

  GetListSurahBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, List<SurahBookmark>>> call(NoParams params) async {
    return await repository.getListSurahBookmark();
  }
}
