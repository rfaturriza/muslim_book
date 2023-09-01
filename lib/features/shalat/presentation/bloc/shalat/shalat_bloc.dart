import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/shalat/domain/entities/geolocation.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/schedule.codegen.dart';
import '../../../domain/entities/shalat_location.codegen.dart';
import '../../../domain/usecase/get_current_location_usecase.dart';
import '../../../domain/usecase/get_shalat_cityid_by_cityname_usecase.dart';
import '../../../domain/usecase/get_shalat_schedule_by_day_usecase.dart';
import '../../../domain/usecase/get_shalat_schedule_by_month_usecase.dart';

part 'shalat_bloc.freezed.dart';

part 'shalat_event.dart';

part 'shalat_state.dart';

@injectable
class ShalatBloc extends Bloc<ShalatEvent, ShalatState> {
  final GetShalatCityIdByCityUseCase getCityId;
  final GetShalatScheduleByDayUseCase getScheduleByDay;
  final GetShalatScheduleByMonthUseCase getScheduleByMonth;
  final GetCurrentLocationUseCase getCurrentLocation;

  ShalatBloc({
    required this.getCityId,
    required this.getScheduleByDay,
    required this.getScheduleByMonth,
    required this.getCurrentLocation,
  }) : super(const ShalatState()) {
    on<GetShalatCityIdByCityEvent>(_onShalatCityIdFetch);
    on<GetShalatScheduleByDayEvent>(_onShalatScheduleByDayFetch);
    on<GetShalatScheduleByMonthEvent>(_onShalatScheduleByMonthFetch);
  }

  void _onShalatCityIdFetch(
    GetShalatCityIdByCityEvent event,
    Emitter<ShalatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getCityId(
      GetShalatCityIdByCityParams(city: event.city),
    );
    emit(
      result.fold(
        (failure) => state.copyWith(isLoading: false, failure: failure),
        (data) => state.copyWith(isLoading: false, location: data.first),
      ),
    );
  }

  void _onShalatScheduleByDayFetch(
    GetShalatScheduleByDayEvent event,
    Emitter<ShalatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final geoLocation = await getCurrentLocation(NoParams());
    final city = geoLocation.fold(
          (failure) => null,
          (data) => data?.city?.split(" ").last.toLowerCase(),
        ) ??
        emptyString;
    final resultCityID = await getCityId(
      GetShalatCityIdByCityParams(city: city),
    );
    final cityID = resultCityID.fold(
          (failure) => null,
          (data) => data.first.id,
        ) ??
        emptyString;
    final resultSchedule = await getScheduleByDay(
      GetShalatScheduleByDayParams(cityID: cityID, day: event.day),
    );
    emit(
      resultSchedule.fold(
        (failure) => state.copyWith(isLoading: false, failure: failure),
        (data) => state.copyWith(isLoading: false, scheduleByDay: data, geoLocation: geoLocation.getOrElse(() => null)),
      ),
    );
  }

  void _onShalatScheduleByMonthFetch(
    GetShalatScheduleByMonthEvent event,
    Emitter<ShalatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getScheduleByMonth(
      GetShalatScheduleByMonthParams(city: event.cityID, month: event.month),
    );
    emit(
      result.fold(
        (failure) => state.copyWith(isLoading: false, failure: failure),
        (data) => state.copyWith(isLoading: false, schedulesByMonth: data),
      ),
    );
  }
}
