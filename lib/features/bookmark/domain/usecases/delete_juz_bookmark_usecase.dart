import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/juz_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class DeleteJuzBookmarkUseCase extends UseCase<Unit, DeleteJuzBookmarkParams> {
  final BookmarkRepository repository;

  DeleteJuzBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteJuzBookmarkParams params) async {
    return await repository.deleteJuzBookmark(params.bookmark);
  }
}

class DeleteJuzBookmarkParams extends Equatable {
  final JuzBookmark bookmark;

  const DeleteJuzBookmarkParams(this.bookmark);

  @override
  List<Object?> get props => [bookmark];
}
