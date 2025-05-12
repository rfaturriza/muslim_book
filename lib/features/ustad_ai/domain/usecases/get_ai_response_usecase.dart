import 'package:injectable/injectable.dart';

import '../repositories/ai_repository.dart';

@injectable
class GetAiResponseUseCase {
  final AiRepository repository;

  GetAiResponseUseCase(this.repository);

  Stream<String> call(String prompt) {
    return repository.getAiResponse(prompt);
  }
}