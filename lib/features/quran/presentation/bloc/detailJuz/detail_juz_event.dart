part of 'detail_juz_bloc.dart';

abstract class JuzDetailEvent extends Equatable {
  const JuzDetailEvent();

  @override
  List<Object?> get props => [];
}

class JuzDetailFetchEvent extends JuzDetailEvent {
  final int juzNumber;

  const JuzDetailFetchEvent({required this.juzNumber});

  @override
  List<Object?> get props => [juzNumber];
}
