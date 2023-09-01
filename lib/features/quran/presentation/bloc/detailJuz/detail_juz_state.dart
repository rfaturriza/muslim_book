part of 'detail_juz_bloc.dart';

abstract class JuzDetailState extends Equatable {
  const JuzDetailState();

  @override
  List<Object?> get props => [];
}

class JuzInitialState extends JuzDetailState {}

class JuzDetailLoadingState extends JuzDetailState {}

class JuzDetailLoadedState extends JuzDetailState {
  final DetailJuz? detailJuz;

  const JuzDetailLoadedState({
    this.detailJuz,
  });

  @override
  List<Object?> get props => [detailJuz];
}

class JuzErrorState extends JuzDetailState {
  final String? message;

  const JuzErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
