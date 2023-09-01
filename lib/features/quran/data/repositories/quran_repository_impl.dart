import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/detail_juz.codegen.dart';
import 'package:quranku/features/quran/domain/entities/detail_surah.codegen.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/surah.codegen.dart';
import '../../domain/repositories/quran_repository.dart';
import '../dataSources/remote/quran_remote_data_source.dart';

@LazySingleton(as: QuranRepository)
class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  const QuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetailSurah?>> getDetailSurah(int surahNumber) async {
    try {
      final detailSurah = await remoteDataSource.getDetailSurah(surahNumber);
      return Right(detailSurah.data?.toEntity());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Surah>?>> getListOfSurah() async {
    try {
      final allSurah = await remoteDataSource.getAllSurah();
      return Right(allSurah.data?.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.response?.statusMessage));
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DetailJuz?>> getDetailJuz(int juzNumber) async {
    try {
      final detailJuz = await remoteDataSource.getDetailJuz(juzNumber);
      return Right(detailJuz.data?.toEntity());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
