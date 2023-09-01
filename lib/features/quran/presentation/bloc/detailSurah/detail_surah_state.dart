part of 'detail_surah_bloc.dart';

abstract class SurahDetailState extends Equatable {
  const SurahDetailState();

  @override
  List<Object?> get props => [];
}

class SurahInitialState extends SurahDetailState {}

class SurahDetailLoadingState extends SurahDetailState {}

class SurahDetailLoadedState extends SurahDetailState {
  final DetailSurah? detailSurah;

  const SurahDetailLoadedState({
    this.detailSurah,
  });

  @override
  List<Object?> get props => [detailSurah];
}

class SurahDetailErrorState extends SurahDetailState {
  final String? message;

  const SurahDetailErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
