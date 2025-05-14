import 'package:injectable/injectable.dart';

import '../../domain/repositories/ai_repository.dart';
import '../ai_datasource.dart';

@LazySingleton(as: AiRepository)
class AiRepositoryImpl implements AiRepository {
  final AiDataSource dataSource;

  AiRepositoryImpl(this.dataSource);

  @override
  Stream<String> getAiResponse(String prompt) {
    return dataSource.streamAiResponse(prompt);
  }
}
