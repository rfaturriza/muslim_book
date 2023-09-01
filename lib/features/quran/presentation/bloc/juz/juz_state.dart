part of 'juz_cubit.dart';

class JuzState extends Equatable {
  const JuzState({
    this.listJuz,
    this.query,
    this.hasReachedMax,
    this.isLoading = false,
  });

  final List<JuzConstant>? listJuz;
  final String? query;
  final bool? hasReachedMax;
  final bool isLoading;

  JuzState copyWith({
    List<JuzConstant>? listJuz,
    String? query,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return JuzState(
      listJuz: listJuz ?? this.listJuz,
      query: query ?? this.query,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [listJuz, query, hasReachedMax, isLoading];
}
