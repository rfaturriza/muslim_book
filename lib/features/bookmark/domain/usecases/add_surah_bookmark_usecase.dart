import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/surah_bookmark.codegen.dart';
import '../repositories/bookmark_repository.dart';

@injectable
class AddSurahBookmarkUseCase extends UseCase<Unit, AddSurahBookmarkParams> {
  final BookmarkRepository repository;

  AddSurahBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddSurahBookmarkParams params) async {
    return await repository.addSurahBookmark(params.bookmark);
  }
}

class AddSurahBookmarkParams extends Equatable {
  final SurahBookmark bookmark;

  const AddSurahBookmarkParams(this.bookmark);

  @override
  List<Object?> get props => [bookmark];
}
