part of 'surah_bloc.dart';

abstract class SurahState extends Equatable {
  const SurahState({this.query});
  final String? query;

  @override
  List<Object?> get props => [query];
}

class SurahInitialState extends SurahState {}

class SurahLoadingState extends SurahState {}

class SurahLoadedState extends SurahState {
  final List<Surah>? listSurah;
  final bool? hasReachedMax;

  const SurahLoadedState({
    this.listSurah,
    this.hasReachedMax,
    super.query,
  });

  SurahLoadedState copyWith({
    List<Surah>? surah,
    bool? hasReachedMax,
    String? query,
  }) {
    return SurahLoadedState(
      listSurah: surah ?? listSurah,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [listSurah, hasReachedMax];
}

class SurahDetailLoadingState extends SurahState {}

class SurahDetailLoadedState extends SurahState {
  final DetailSurah? detailSurah;

  const SurahDetailLoadedState({
    this.detailSurah,
  });

  @override
  List<Object?> get props => [detailSurah];
}

class SurahErrorState extends SurahState {
  final String? message;

  const SurahErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
