import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/features/bookmark/domain/entities/juz_bookmark.codegen.dart';
import 'package:quranku/features/bookmark/domain/entities/surah_bookmark.codegen.dart';
import 'package:quranku/features/bookmark/domain/entities/verse_bookmark.codegen.dart';
import 'package:quranku/features/bookmark/domain/repositories/bookmark_repository.dart';

import '../dataSources/local/bookmark_local_data_source.dart';
import '../models/juz_bookmark_model.codegen.dart';
import '../models/surah_bookmark_model.codegen.dart';
import '../models/verse_bookmark_model.codegen.dart';

@LazySingleton(as: BookmarkRepository)
class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource _dataSource;
  const BookmarkRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Unit>> addJuzBookmark(JuzBookmark juzBookmark) async {
    return  await _dataSource.addJuzBookmark(JuzBookmarkModel.fromEntity(juzBookmark));
  }

  @override
  Future<Either<Failure, Unit>> addSurahBookmark(SurahBookmark surahBookmark) async {
    return await _dataSource.addSurahBookmark(SurahBookmarkModel.fromEntity(surahBookmark));
  }

  @override
  Future<Either<Failure, Unit>> addVerseBookmark(VerseBookmark verseBookmark) async {
    return await _dataSource.addVerseBookmark(VerseBookmarkModel.fromEntity(verseBookmark));
  }

  @override
  Future<Either<Failure, Unit>> deleteJuzBookmark(JuzBookmark juzBookmark) async {
    return await _dataSource.deleteJuzBookmark(JuzBookmarkModel.fromEntity(juzBookmark));

  }

  @override
  Future<Either<Failure, Unit>> deleteSurahBookmark(SurahBookmark surahBookmark) async {
    return await _dataSource.deleteSurahBookmark(SurahBookmarkModel.fromEntity(surahBookmark));
  }

  @override
  Future<Either<Failure, Unit>> deleteVerseBookmark(VerseBookmark verseBookmark) async {
    return await _dataSource.deleteVerseBookmark(VerseBookmarkModel.fromEntity(verseBookmark));
  }

  @override
  Future<Either<Failure, List<JuzBookmark>>> getListJuzBookmark() async {
    final result = await _dataSource.getListJuzBookmark();
    return result.map((r) => r.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<SurahBookmark>>> getListSurahBookmark() async {
    final result = await _dataSource.getListSurahBookmark();
    return result.map((r) => r.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<VerseBookmark>>> getListVersesBookmark() async {
    final result = await _dataSource.getListVersesBookmark();
    return result.map((r) => r.map((e) => e.toEntity()).toList());
  }

}