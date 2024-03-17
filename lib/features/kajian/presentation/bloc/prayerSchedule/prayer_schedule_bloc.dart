import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';

import '../../../../shalat/domain/usecase/get_current_location_usecase.dart';
import '../../../data/models/ramadhan_schedule_request_model.codegen.dart';
import '../../../domain/entities/ramadhan_schedules.codegen.dart';
import '../../../domain/usecases/get_ramadhan_schedules_usecase.dart';

part 'prayer_schedule_bloc.freezed.dart';
part 'prayer_schedule_event.dart';
part 'prayer_schedule_state.dart';

@injectable
class PrayerScheduleBloc
    extends Bloc<PrayerScheduleEvent, PrayerScheduleState> {
  final GetRamadhanSchedulesUseCase _getRamadhanSchedulesUseCase;
  final GetCurrentLocationUseCase _getCurrentLocation;
  final int limit = 10;

  PrayerScheduleBloc(
    this._getRamadhanSchedulesUseCase,
    this._getCurrentLocation,
  ) : super(const PrayerScheduleState()) {
    on<_FetchRamadhanSchedules>(_onFetchRamadhanSchedules);
    on<_ToggleNearby>(_onToggleNearby);
  }

  void _onFetchRamadhanSchedules(
    _FetchRamadhanSchedules event,
    Emitter<PrayerScheduleState> emit,
  ) async {
    if (state.lastPage != null && event.pageNumber > state.lastPage!) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (event.pageNumber == 1) {
      emit(state.copyWith(ramadhanSchedules: []));
    }

    try {
      var request = RamadhanScheduleRequestModel(
        type: 'pagination',
        page: event.pageNumber,
        limit: limit,
        orderBy: 'pray_date',
        sortBy: 'desc',
        relations: 'studyLocation',
      );
      if (state.isNearby) {
        final geoLocation = await _getCurrentLocation(
          GetCurrentLocationParams(locale: event.locale),
        );
        request = request.copyWith(
          latitude: geoLocation.asRight()?.coordinate?.lat ?? 0,
          longitude: geoLocation.asRight()?.coordinate?.lon ?? 0,
          isNearest: 1,
        );
      }
      final result = await _getRamadhanSchedulesUseCase(
        request,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(status: FormzSubmissionStatus.failure),
        ),
        (data) {
          final currentData = state.ramadhanSchedules;
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            ramadhanSchedules: currentData + (data?.data ?? []),
            currentPage: data?.meta.currentPage ?? 0,
            totalData: data?.meta.total ?? 0,
            lastPage: data?.meta.lastPage ?? 0,
          ));
        },
      );
    } catch (e) {
      log('Error: $e', name: 'PrayerScheduleBloc');
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _onToggleNearby(
    _ToggleNearby event,
    Emitter<PrayerScheduleState> emit,
  ) async {
    emit(state.copyWith(isNearby: !state.isNearby));
  }
}
