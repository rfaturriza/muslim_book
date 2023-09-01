part of 'network_info_bloc.dart';

abstract class NetworkInfoEvent extends Equatable {
  const NetworkInfoEvent();

  @override
  List<Object?> get props => [];
}

class ConnectedConnectivityEvent extends NetworkInfoEvent {}

class DisconnectedConnectivityEvent extends NetworkInfoEvent {}
