import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kajian_schedule.codegen.dart';

@injectable
class GetNearbyKajianListUseCase
    implements UseCase<KajianSchedules, GetNearbyKajianListUseCaseParams> {
  final KajianHubRepository repository;

  GetNearbyKajianListUseCase(this.repository);

  @override
  Future<Either<Failure, KajianSchedules>> call(
    GetNearbyKajianListUseCaseParams params,
  ) async {
    final result = await repository.getNearbyKajianList(
      latitude: params.latitude,
      longitude: params.longitude,
    );
    return result;
  }
}

class GetNearbyKajianListUseCaseParams extends Equatable {
  final double latitude;
  final double longitude;

  const GetNearbyKajianListUseCaseParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}
