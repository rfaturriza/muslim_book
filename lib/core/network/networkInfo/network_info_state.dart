part of 'network_info_bloc.dart';

abstract class NetworkInfoState extends Equatable {
  const NetworkInfoState();

  @override
  List<Object?> get props => [];
}

class NetworkInfoLoadingState extends NetworkInfoState {}

class NetworkInfoConnectedState extends NetworkInfoState {}

class NetworkInfoDisconnectedState extends NetworkInfoState {}
