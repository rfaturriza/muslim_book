import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/core/utils/helper.dart';
import 'package:quranku/features/shalat/domain/entities/geolocation.codegen.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../qibla/domain/usecases/stream_permission_location_usecase.dart';
import '../../../domain/entities/schedule.codegen.dart';
import '../../../domain/entities/shalat_location.codegen.dart';
import '../../../domain/usecase/get_current_location_usecase.dart';
import '../../../domain/usecase/get_shalat_cityid_by_citiesname_usecase.dart';
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
  final StreamPermissionLocationUseCase streamPermissionLocation;
  final GetShalatCityIdByCitiesUseCase getCityIdByCities;

  StreamSubscription<Either<Failure, LocationStatus>>?
      _streamPermissionLocation;

  ShalatBloc({
    required this.getCityId,
    required this.getScheduleByDay,
    required this.getScheduleByMonth,
    required this.getCurrentLocation,
    required this.streamPermissionLocation,
    required this.getCityIdByCities,
  }) : super(const ShalatState()) {
    _onStreamPermissionLocation();

    on<GetShalatCityIdByCityEvent>(_onShalatCityIdFetch);
    on<GetShalatScheduleByDayEvent>(_onShalatScheduleByDayFetch);
    on<GetShalatScheduleByMonthEvent>(_onShalatScheduleByMonthFetch);
    on<StreamPermissionLocationEvent>(_onStreamLocationEvent);
  }

  void _onStreamPermissionLocation() {
    _streamPermissionLocation = streamPermissionLocation(NoParams()).listen(
      (event) {
        add(ShalatEvent.streamPermissionLocationEvent(event));
        final isSuccess = event.isRight();
        if (isSuccess) {
          final locationStatus = event.asRight();
          final isServiceEnabled = locationStatus.enabled;
          final isPermissionGranted =
              locationStatus.status == LocationPermission.always ||
                  locationStatus.status == LocationPermission.whileInUse;
          if (isServiceEnabled && isPermissionGranted) {
            add(GetShalatScheduleByDayEvent(day: DateTime.now().day));
          }
        }
      },
    );
  }

  void _onStreamLocationEvent(
    StreamPermissionLocationEvent event,
    Emitter<ShalatState> emit,
  ) async {
    final isSuccess = event.locationStatus?.isRight() == true;
    final data = isSuccess ? event.locationStatus?.asRight() : null;
    emit(state.copyWith(
      locationStatus: data,
    ));
  }

  void _onShalatCityIdFetch(
    GetShalatCityIdByCityEvent event,
    Emitter<ShalatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getCityId(
      GetShalatCityIdByCityParams(city: event.city),
    );
    emit(state.copyWith(
      isLoading: false,
      location: result.fold(
        (failure) => left(
          GeneralFailure(
            message: failure.message ?? LocaleKeys.locationNotFound.tr(),
          ),
        ),
        (data) => right(data.first),
      ),
    ));
  }

  void _onShalatScheduleByDayFetch(
    GetShalatScheduleByDayEvent event,
    Emitter<ShalatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final geoLocation = await getCurrentLocation(NoParams());
    final service = await Geolocator.isLocationServiceEnabled();
    final status = await Geolocator.checkPermission();

    emit(state.copyWith(
      locationStatus: LocationStatus(service, status),
    ));

    if (geoLocation.isLeft()) {
      emit(state.copyWith(
        isLoading: false,
        scheduleByDay: left(
          GeneralFailure(
            message: LocaleKeys.locationNotFound.tr(),
          ),
        ),
      ));
      return;
    }
    final cities = geoLocation.getOrElse(() => null)?.cities?.map((e) {
          return getCityNameWithoutPrefix(e);
        }).toList() ??
        [];
    final regions = geoLocation.getOrElse(() => null)?.regions?.map((e) {
          return getCityNameWithoutPrefix(e);
        }).toList() ??
        [];

    final resultCityID = await getCityIdByCities(
      GetShalatCityIdByCitiesParams(cities: cities + regions),
    );

    if (resultCityID.isLeft()) {
      emit(state.copyWith(
        isLoading: false,
        scheduleByDay: left(
          GeneralFailure(
            message: LocaleKeys.locationNotFound.tr(),
          ),
        ),
      ));
      return;
    }

    final cityID = resultCityID.fold(
          (failure) => null,
          (data) => data.first.id,
        ) ??
        emptyString;
    final resultSchedule = await getScheduleByDay(
      GetShalatScheduleByDayParams(
        cityID: cityID,
        day: event.day ?? DateTime.now().day,
      ),
    );
    emit(
      state.copyWith(
        isLoading: false,
        scheduleByDay: resultSchedule.fold(
          (failure) => left(
            GeneralFailure(
              message: failure.message ?? LocaleKeys.locationNotFound.tr(),
            ),
          ),
          (data) => right(data),
        ),
        geoLocation: geoLocation.getOrElse(() => null),
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
    final service = await Geolocator.isLocationServiceEnabled();
    final status = await Geolocator.checkPermission();

    emit(state.copyWith(
      locationStatus: LocationStatus(service, status),
    ));
    emit(
      state.copyWith(
        isLoading: false,
        scheduleByMonth: result.fold(
          (failure) => left(
            GeneralFailure(
              message: failure.message ?? LocaleKeys.locationNotFound.tr(),
            ),
          ),
          (data) => right(data),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _streamPermissionLocation?.cancel();
    return super.close();
  }
}
