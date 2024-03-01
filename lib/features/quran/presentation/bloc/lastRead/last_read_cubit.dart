import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';

import '../../../domain/entities/last_read_juz.codegen.dart';
import '../../../domain/entities/last_read_surah.codegen.dart';
import '../../../domain/usecases/delete_all_last_read_juz_usecase.dart';
import '../../../domain/usecases/delete_all_last_read_surah_usecase.dart';
import '../../../domain/usecases/delete_last_read_juz_usecase.dart';
import '../../../domain/usecases/delete_last_read_surah_usecase.dart';
import '../../../domain/usecases/get_last_read_juz_usecase.dart';
import '../../../domain/usecases/get_last_read_surah_usecase.dart';
import '../../../domain/usecases/set_last_read_juz_usecase.dart';
import '../../../domain/usecases/set_last_read_surah_usecase.dart';

part 'last_read_cubit.freezed.dart';
part 'last_read_state.dart';

@injectable
class LastReadCubit extends Cubit<LastReadState> {
  final GetLastReadSurahUseCase _getLastReadSurahUseCase;
  final GetLastReadJuzUseCase _getLastReadJuzUseCase;
  final SetLastReadSurahUseCase _setLastReadSurahUseCase;
  final SetLastReadJuzUseCase _setLastReadJuzUseCase;
  final DeleteLastReadSurahUseCase _deleteLastReadSurahUseCase;
  final DeleteLastReadJuzUseCase _deleteLastReadJuzUseCase;
  final DeleteAllLastReadSurahUseCase _deleteAllLastReadSurahUseCase;
  final DeleteAllLastReadJuzUseCase _deleteAllLastReadJuzUseCase;

  LastReadCubit(
    this._getLastReadSurahUseCase,
    this._getLastReadJuzUseCase,
    this._setLastReadSurahUseCase,
    this._setLastReadJuzUseCase,
    this._deleteLastReadSurahUseCase,
    this._deleteLastReadJuzUseCase,
    this._deleteAllLastReadSurahUseCase,
    this._deleteAllLastReadJuzUseCase,
  ) : super(const LastReadState());

  void setLastReadSurah(LastReadSurah surah) async {
    emit(state.copyWith(statusSurah: FormzSubmissionStatus.inProgress));
    final result = await _setLastReadSurahUseCase(
      SetLastReadSurahUseCaseParams(
        surah: surah,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.success,
          lastReadSurah: state.lastReadSurah + [surah],
        ),
      ),
    );
  }

  void setLastReadJuz(LastReadJuz juz) async {
    emit(
      state.copyWith(
        statusJuz: FormzSubmissionStatus.inProgress,
      ),
    );
    final result = await _setLastReadJuzUseCase(
      SetLastReadJuzUseCaseParams(
        juz: juz,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.success,
          lastReadJuz: state.lastReadJuz + [juz],
        ),
      ),
    );
  }

  void getLastReadSurah() async {
    emit(state.copyWith(statusSurah: FormzSubmissionStatus.inProgress));
    final result = await _getLastReadSurahUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.failure,
        ),
      ),
      (surah) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.success,
          lastReadSurah: surah ?? [],
            ),
          ),
    );
  }

  void getLastReadJuz() async {
    emit(state.copyWith(statusJuz: FormzSubmissionStatus.inProgress));
    final result = await _getLastReadJuzUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.failure,
        ),
      ),
      (juz) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.success,
          lastReadJuz: juz ?? [],
            ),
          ),
    );
  }

  void deleteLastReadSurah(DateTime createdAt) async {
    final result = await _deleteLastReadSurahUseCase(createdAt);
    final currentList = [...state.lastReadSurah];
    currentList.removeWhere((e) => e.createdAt == createdAt);
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.success,
          lastReadSurah: currentList,
        ),
      ),
    );
  }

  void deleteLastReadJuz(DateTime createdAt) async {
    final result = await _deleteLastReadJuzUseCase(createdAt);
    final currentList = [...state.lastReadJuz];
    currentList.removeWhere((e) => e.createdAt == createdAt);
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.success,
          lastReadJuz: currentList,
        ),
      ),
    );
  }

  void deleteAllLastReadSurah() async {
    final result = await _deleteAllLastReadSurahUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusSurah: FormzSubmissionStatus.success,
          lastReadSurah: [],
        ),
      ),
    );
  }

  void deleteAllLastReadJuz() async {
    final result = await _deleteAllLastReadJuzUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.failure,
        ),
      ),
      (unit) => emit(
        state.copyWith(
          statusJuz: FormzSubmissionStatus.success,
          lastReadJuz: [],
        ),
      ),
    );
  }

  void deleteAllLastRead() async {
    deleteAllLastReadSurah();
    deleteAllLastReadJuz();
  }
}
