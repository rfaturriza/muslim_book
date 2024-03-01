import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/data/models/detail_juz_model.codegen.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/detail_surah_model.codegen.dart';
import '../../models/surah_model.codegen.dart';
import 'quran_remote_data_source.dart';

@LazySingleton(as: QuranRemoteDataSource)
class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final Dio dio;

  QuranRemoteDataSourceImpl({required this.dio});

  @override
  Future<SurahResponseModel> getAllSurah() async {
    const endpoint = 'surah';
    try {
      final result = await dio.get(endpoint);
      return SurahResponseModel.fromJson(result.data);
    } on SocketException catch (e) {
      throw ServerException(e);
    } on DioException catch (e) {
      throw ServerException(e);
    } catch (e) {
      throw ServerException(Exception('Unknown Error'));
    }
  }

  @override
  Future<DetailSurahResponseModel> getDetailSurah(int surahNumber) async {
    final endpoint = 'surah/$surahNumber';
    try {
      final result = await dio.get(endpoint);
      return DetailSurahResponseModel.fromJson(result.data);
    } on SocketException catch (e) {
      throw ServerException(e);
    } on DioException catch (e) {
      throw ServerException(e);
    } catch (e) {
      throw ServerException(Exception('Unknown Error'));
    }
  }

  @override
  Future<DetailJuzResponseModel> getDetailJuz(int juzNumber) async {
    final endpoint = 'juz/$juzNumber';
    try {
      final result = await dio.get(endpoint);
      return DetailJuzResponseModel.fromJson(result.data);
    } on SocketException catch (e) {
      throw ServerException(e);
    } on DioException catch (e) {
      throw ServerException(e);
    } catch (e) {
      throw ServerException(Exception('Unknown Error'));
    }
  }
}
