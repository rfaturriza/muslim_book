import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/detail_surah.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_detail_surah_usecase.dart';

part 'detail_surah_event.dart';

part 'detail_surah_state.dart';

@injectable
class SurahDetailBloc extends Bloc<SurahDetailEvent, SurahDetailState> {
  final GetDetailSurahUseCase getDetailSurah;

  SurahDetailBloc({
    required GetDetailSurahUseCase detailSurah,
  })  : getDetailSurah = detailSurah,
        super(SurahInitialState()) {
    on<SurahDetailFetchEvent>(_onSurahFetchDetail);
  }

  void _onSurahFetchDetail(SurahDetailFetchEvent event, emit) async {
    emit(SurahDetailLoadingState());
    final failureOrSurah =
        await getDetailSurah(Params(number: event.surahNumber ?? 1));
    emit(
      failureOrSurah.fold(
        (failure) =>
            SurahDetailErrorState(message: mapFailureToMessage(failure)),
        (surahDetail) => SurahDetailLoadedState(detailSurah: surahDetail),
      ),
    );
  }
}
