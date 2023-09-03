import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/verse_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class DeleteVerseBookmarkUseCase
    extends UseCase<Unit, DeleteVerseBookmarkParams> {
  final BookmarkRepository repository;

  DeleteVerseBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteVerseBookmarkParams params) async {
    return await repository.deleteVerseBookmark(params.bookmark);
  }
}

class DeleteVerseBookmarkParams extends Equatable {
  final VerseBookmark bookmark;

  const DeleteVerseBookmarkParams(this.bookmark);

  @override
  List<Object?> get props => [bookmark];
}
