import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/verse_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class AddVerseBookmarkUseCase extends UseCase<Unit, AddVerseBookmarkParams> {
  final BookmarkRepository repository;

  AddVerseBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddVerseBookmarkParams params) async {
    return await repository.addVerseBookmark(params.verseBookmark);
  }
}

class AddVerseBookmarkParams extends Equatable {
  final VerseBookmark verseBookmark;

  const AddVerseBookmarkParams(this.verseBookmark);

  @override
  List<Object?> get props => [verseBookmark];
}
