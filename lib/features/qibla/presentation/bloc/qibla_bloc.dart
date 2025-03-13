import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/usecases/usecase.dart';
import 'package:quranku/core/utils/extension/extension.dart';
import 'package:quranku/features/qibla/domain/usecases/stream_permission_location_usecase.dart';
import 'package:quranku/features/qibla/domain/usecases/stream_qiblah_usecase.dart';

import '../../../../core/error/failures.dart';

part 'qibla_bloc.freezed.dart';
part 'qibla_event.dart';
part 'qibla_state.dart';

@injectable
class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  final StreamPermissionLocationUseCase streamPermissionLocation;
  final StreamQiblaUseCase streamQibla;
  StreamSubscription<Either<Failure, LocationStatus>>? _subscriptionLocation;
  StreamSubscription<Either<Failure, QiblahDirection>>? _subscriptionQibla;

  QiblaBloc({
    required this.streamPermissionLocation,
    required this.streamQibla,
  }) : super(const QiblaState()) {
    _init();
    _streamLocationChanges();
    _streamQiblaChanges();
    on<StreamLocationEvent>(_onStreamLocationEvent);
    on<StreamQiblaEvent>(_onStreamQiblaEvent);
  }

  Future<void> _init() async {
    final deviceSupport = await FlutterQiblah.androidDeviceSensorSupport();
    if (deviceSupport == false) {
      add(
        const QiblaEvent.streamLocationEvent(
          Left(
            GeneralFailure(message: 'Device Not Supported'),
          ),
        ),
      );
    }
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Geolocator.checkPermission().then((value) async {
      if (value.isNotGranted) {
        final permission = await Geolocator.requestPermission();
        if (permission.isGranted) {
          add(
            QiblaEvent.streamLocationEvent(
              Right(
                LocationStatus(true, permission),
              ),
            ),
          );
        } else {
          add(
            const QiblaEvent.streamLocationEvent(
              Left(
                GeneralFailure(message: 'Permission Denied'),
              ),
            ),
          );
        }
      }
    });
  }

  void _streamLocationChanges() {
    _subscriptionLocation = streamPermissionLocation(NoParams()).listen(
      (event) {
        add(QiblaEvent.streamLocationEvent(event));
      },
    );
  }

  void _streamQiblaChanges() {
    _subscriptionQibla = streamQibla(NoParams()).listen(
      (event) {
        add(QiblaEvent.streamQiblaEvent(event));
      },
    );
  }

  void _onStreamLocationEvent(
      StreamLocationEvent event, Emitter<QiblaState> emit) async {
    emit(state.copyWith(
      locationStatusResult: event.locationStatus,
      isLoading: false,
    ));
  }

  void _onStreamQiblaEvent(
      StreamQiblaEvent event, Emitter<QiblaState> emit) async {
    emit(state.copyWith(
      qiblaDirectionResult: event.qiblaDirection,
      isLoading: false,
    ));
  }

  @override
  Future<void> close() {
    _subscriptionLocation?.cancel();
    _subscriptionQibla?.cancel();
    return super.close();
  }
}
