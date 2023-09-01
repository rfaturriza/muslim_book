import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/detail_juz.codegen.dart';
import '../../../domain/usecases/get_detail_juz_usecase.dart';

part 'detail_juz_event.dart';

part 'detail_juz_state.dart';

@injectable
class JuzDetailBloc extends Bloc<JuzDetailEvent, JuzDetailState> {
  final GetDetailJuzUseCase getDetailJuz;

  JuzDetailBloc({
    required GetDetailJuzUseCase detailJuz,
  })  : getDetailJuz = detailJuz,
        super(JuzInitialState()) {
    on<JuzDetailFetchEvent>(_onJuzFetchDetail);
  }

  void _onJuzFetchDetail(JuzDetailFetchEvent event, emit) async {
    emit(JuzDetailLoadingState());
    final failureOrJuz = await getDetailJuz(Params(number: event.juzNumber));
    emit(
      failureOrJuz.fold(
        (failure) => JuzErrorState(message: mapFailureToMessage(failure)),
        (juzDetail) => JuzDetailLoadedState(detailJuz: juzDetail),
      ),
    );
  }
}
