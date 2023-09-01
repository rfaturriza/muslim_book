part of 'surah_bloc.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object?> get props => [];
}

class SurahFetchEvent extends SurahEvent {
  final int? page;
  final int? perPage;

  const SurahFetchEvent({this.page, this.perPage});

  @override
  List<Object?> get props => [page, perPage];
}

class SurahFetchDetailEvent extends SurahEvent {
  final int? surahNumber;

  const SurahFetchDetailEvent({this.surahNumber});

  @override
  List<Object?> get props => [surahNumber];
}

class SurahFetchSearchEvent extends SurahEvent {
  final String? query;
  const SurahFetchSearchEvent({this.query});

  @override
  List<Object?> get props => [query];
}
