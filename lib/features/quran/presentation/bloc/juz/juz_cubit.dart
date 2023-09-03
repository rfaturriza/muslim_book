import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/quran/domain/entities/juz.codegen.dart';

part 'juz_state.dart';

@injectable
class JuzBloc extends Cubit<JuzState> {
  JuzBloc() : super(JuzState(listJuz: JuzConstant.juzList));

  void searchJuz(String query) {
    emit(state.copyWith(isLoading: true, query: query));
    if (query.isEmpty) {
      emit(
        state.copyWith(
          listJuz: JuzConstant.juzList,
          isLoading: false,
        ),
      );
      return;
    }
    final filteredJuzByDesc = JuzConstant.juzList
        .where(
          (e) => e.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    final filteredJuzByName = JuzConstant.juzList
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final filteredJuz = [...filteredJuzByDesc, ...filteredJuzByName];
    filteredJuz.toSet().toList();

    emit(
      state.copyWith(
        listJuz: filteredJuz,
        isLoading: false,
      ),
    );
  }
}
