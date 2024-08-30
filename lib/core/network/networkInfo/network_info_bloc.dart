import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'network_info_event.dart';
part 'network_info_state.dart';

@injectable
class NetworkInfoBloc extends Bloc<NetworkInfoEvent, NetworkInfoState> {
  StreamSubscription? connectivitySubscription;

  NetworkInfoBloc() : super(NetworkInfoLoadingState()) {
    final Connectivity connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        add(DisconnectedConnectivityEvent());
      } else {
        add(ConnectedConnectivityEvent());
      }
    });
    checkConnection(connectivity: connectivity);
    on<ConnectedConnectivityEvent>(_onConnectedConnectivityEvent);
    on<DisconnectedConnectivityEvent>(_onDisconnectedConnectivityEvent);
  }

  void _onConnectedConnectivityEvent(ConnectedConnectivityEvent event, emit) {
    emit(NetworkInfoConnectedState());
  }

  void _onDisconnectedConnectivityEvent(
      DisconnectedConnectivityEvent event, emit) {
    emit(NetworkInfoDisconnectedState());
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }

  Future<void> checkConnection({required Connectivity connectivity}) async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      add(DisconnectedConnectivityEvent());
    } else {
      add(ConnectedConnectivityEvent());
    }
  }
}
