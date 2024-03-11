import 'package:quranku/features/kajian/data/models/kajian_schedule_request_model.codegen.dart';
import 'package:quranku/features/kajian/data/models/kajian_schedule_response_model.codegen.dart';

abstract class KajianRemoteDataSource {
  Future<List<KajianScheduleResponseModel>> getKajianSchedule({
    required KajianScheduleRequestModel request,
  });
}
