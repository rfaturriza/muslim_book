part of 'detail_surah_bloc.dart';

abstract class SurahDetailEvent extends Equatable {
  const SurahDetailEvent();

  @override
  List<Object?> get props => [];
}

class SurahDetailFetchEvent extends SurahDetailEvent {
  final int? surahNumber;

  const SurahDetailFetchEvent({this.surahNumber});

  @override
  List<Object?> get props => [surahNumber];
}
