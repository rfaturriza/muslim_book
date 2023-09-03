import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/juz_bookmark.codegen.dart';
import '../entities/surah_bookmark.codegen.dart';
import '../entities/verse_bookmark.codegen.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<VerseBookmark>>> getListVersesBookmark();

  Future<Either<Failure, List<SurahBookmark>>> getListSurahBookmark();

  Future<Either<Failure, List<JuzBookmark>>> getListJuzBookmark();

  Future<Either<Failure, Unit>> addVerseBookmark(
    VerseBookmark verseBookmark,
  );

  Future<Either<Failure, Unit>> addSurahBookmark(
    SurahBookmark surahBookmark,
  );

  Future<Either<Failure, Unit>> addJuzBookmark(
    JuzBookmark juzBookmark,
  );

  Future<Either<Failure, Unit>> deleteVerseBookmark(
    VerseBookmark verseBookmark,
  );

  Future<Either<Failure, Unit>> deleteSurahBookmark(
    SurahBookmark surahBookmark,
  );

  Future<Either<Failure, Unit>> deleteJuzBookmark(
    JuzBookmark juzBookmark,
  );
}