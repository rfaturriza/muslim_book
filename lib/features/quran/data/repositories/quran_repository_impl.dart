import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/detail_juz.codegen.dart';
import 'package:quranku/features/quran/domain/entities/detail_surah.codegen.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/surah.codegen.dart';
import '../../domain/repositories/quran_repository.dart';
import '../dataSources/local/quran_local_data_source.dart';
import '../dataSources/remote/quran_remote_data_source.dart';

@LazySingleton(as: QuranRepository)
class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;
  final QuranLocalDataSource localDataSource;

  const QuranRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, DetailSurah?>> getDetailSurah(int surahNumber) async {
    try {
      final detailSurah = await remoteDataSource.getDetailSurah(surahNumber);
      return Right(detailSurah.data?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Surah>?>> getListOfSurah() async {
    try {
      final allSurah = await remoteDataSource.getAllSurah();
      return Right(allSurah.data?.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DetailJuz?>> getDetailJuz(int juzNumber) async {
    try {
      final detailJuz = await remoteDataSource.getDetailJuz(juzNumber);
      return Right(detailJuz.data?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Surah>?>> getCacheAllSurah() async {
    final result = await localDataSource.getAllSurah();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, DetailJuz?>> getCacheDetailJuz(int juzNumber) async {
    final result = await localDataSource.getDetailJuz(juzNumber);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, DetailSurah?>> getCacheDetailSurah(int surahNumber) async {
    final result = await localDataSource.getDetailSurah(surahNumber);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> setCacheAllSurah(List<Surah> surah) async {
    final result = await localDataSource.setAllSurah(surah.map((e) => e.toModel()).toList());
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setCacheDetailJuz(DetailJuz juz) async {
    final result = await localDataSource.setDetailJuz(juz.toModel());
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Unit>> setCacheDetailSurah(DetailSurah surah) async {
    final result = await localDataSource.setDetailSurah(surah.toModel());
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
