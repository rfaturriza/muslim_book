import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_ai_response_usecase.dart';

part 'ustad_ai_state.dart';
part 'ustad_ai_event.dart';
part 'ustad_ai_bloc.freezed.dart';

@injectable
class UstadAiBloc extends Bloc<UstadAiEvent, UstadAiState> {
  final GetAiResponseUseCase useCase;
  UstadAiBloc(
    this.useCase,
  ) : super(const UstadAiState.initial()) {
    on<_SendPrompt>(_onSendPrompt);
  }
  void _onSendPrompt(_SendPrompt event, emit) async {
    String accumulated = '';
    emit(const UstadAiState.streaming(text: '', isGenerating: true));

    try {
      await for (final chunk in useCase(event.prompt)) {
        accumulated += chunk;
        emit(UstadAiState.streaming(text: accumulated, isGenerating: true));
      }
      emit(UstadAiState.streaming(text: accumulated, isGenerating: false));
    } catch (e) {
      emit(UstadAiState.error(e.toString()));
    }
  }
}
