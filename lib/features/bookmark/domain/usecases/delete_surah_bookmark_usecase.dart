import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/surah_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class DeleteSurahBookmarkUseCase
    extends UseCase<Unit, DeleteSurahBookmarkParams> {
  final BookmarkRepository repository;

  DeleteSurahBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteSurahBookmarkParams params) async {
    return await repository.deleteSurahBookmark(params.bookmark);
  }
}

class DeleteSurahBookmarkParams extends Equatable {
  final SurahBookmark bookmark;

  const DeleteSurahBookmarkParams(this.bookmark);

  @override
  List<Object?> get props => [bookmark];
}
