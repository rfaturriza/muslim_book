import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/domain/entities/detail_surah.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/surah.codegen.dart';
import '../../../domain/usecases/get_all_surah_usecase.dart';

part 'surah_event.dart';

part 'surah_state.dart';

@injectable
class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetListSurahUseCase getListSurah;

  SurahBloc({
    required GetListSurahUseCase listSurah,
  })  : getListSurah = listSurah,
        super(SurahInitialState()) {
    on<SurahFetchEvent>(_onSurahFetch);
    on<SurahFetchSearchEvent>(_onSurahFetchSearch);
  }

  void _onSurahFetch(SurahFetchEvent event, emit) async {
    emit(SurahLoadingState());
    final failureOrSurah = await getListSurah(NoParams());
    emit(
      failureOrSurah.fold(
        (failure) => SurahErrorState(message: mapFailureToMessage(failure)),
        (surah) => SurahLoadedState(listSurah: surah),
      ),
    );
  }

  void _onSurahFetchSearch(SurahFetchSearchEvent event, emit) async {
    emit(SurahLoadingState());
    final failureOrSurah = await getListSurah(NoParams());
    emit(
      failureOrSurah.fold(
        (failure) => SurahErrorState(message: mapFailureToMessage(failure)),
        (surah) {
          final filteredSurahId = surah
                  ?.where((val) =>
                      val.name?.transliteration?.id?.toLowerCase().contains(
                          event.query?.toLowerCase() ?? emptyString) ==
                      true)
                  .toList() ??
              [];

          final filteredSurahEn = surah
                  ?.where((val) =>
                      val.name?.translation?.en?.toLowerCase().contains(
                          event.query?.toLowerCase() ?? emptyString) ==
                      true)
                  .toList() ??
              [];

          final filteredSurah = filteredSurahId + filteredSurahEn;

          filteredSurah.removeWhere((val) =>
              filteredSurah
                  .where((val2) => val2.number == val.number)
                  .toList()
                  .length >
              1);

          if (event.query == emptyString) {
            return SurahLoadedState(listSurah: surah);
          }

          return SurahLoadedState(listSurah: filteredSurah, query: event.query);
        },
      ),
    );
  }
}
