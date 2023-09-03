import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/juz_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class AddJuzBookmarkUseCase extends UseCase<Unit, AddJuzBookmarkParams> {
  final BookmarkRepository repository;

  AddJuzBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddJuzBookmarkParams params) async {
    return await repository.addJuzBookmark(params.bookmark);
  }
}

class AddJuzBookmarkParams extends Equatable {
  final JuzBookmark bookmark;

  const AddJuzBookmarkParams(this.bookmark);

  @override
  List<Object?> get props => [bookmark];
}
