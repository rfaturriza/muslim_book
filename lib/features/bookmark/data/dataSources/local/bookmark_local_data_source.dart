import 'package:dartz/dartz.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/features/bookmark/data/models/juz_bookmark_model.codegen.dart';
import 'package:quranku/features/bookmark/data/models/surah_bookmark_model.codegen.dart';
import 'package:quranku/features/bookmark/data/models/verse_bookmark_model.codegen.dart';

abstract class BookmarkLocalDataSource {
  Future<Either<Failure, List<VerseBookmarkModel>>> getListVersesBookmark();

  Future<Either<Failure, List<SurahBookmarkModel>>> getListSurahBookmark();

  Future<Either<Failure, List<JuzBookmarkModel>>> getListJuzBookmark();

  Future<Either<Failure, Unit>> addVerseBookmark(
    VerseBookmarkModel verseBookmark,
  );

  Future<Either<Failure, Unit>> addSurahBookmark(
    SurahBookmarkModel surahBookmark,
  );

  Future<Either<Failure, Unit>> addJuzBookmark(
    JuzBookmarkModel juzBookmark,
  );

  Future<Either<Failure, Unit>> deleteVerseBookmark(
    VerseBookmarkModel verseBookmark,
  );

  Future<Either<Failure, Unit>> deleteSurahBookmark(
    SurahBookmarkModel surahBookmark,
  );

  Future<Either<Failure, Unit>> deleteJuzBookmark(
    JuzBookmarkModel juzBookmark,
  );
}
