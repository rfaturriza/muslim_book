import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/dataSources/remote/kajian_remote_data_source.dart';
import 'package:quranku/features/kajian/data/models/kajian_schedule_request_model.codegen.dart';
import 'package:quranku/features/kajian/data/models/kajian_schedule_response_model.codegen.dart';

@LazySingleton(as: KajianRemoteDataSource)
class KajianRemoteDataSourceImpl implements KajianRemoteDataSource {
  final Dio dio;

  KajianRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<KajianScheduleResponseModel>> getKajianSchedule(
      {required KajianScheduleRequestModel request}) {
    // TODO: implement getKajianSchedule
    throw UnimplementedError();
  }
}
