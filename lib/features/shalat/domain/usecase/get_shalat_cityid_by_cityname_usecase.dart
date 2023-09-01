import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/shalat/domain/repositories/location_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/shalat_location.codegen.dart';

@injectable
class GetShalatCityIdByCityUseCase implements UseCase<List<ShalatLocation>?, GetShalatCityIdByCityParams> {
  final LocationRepository repository;

  GetShalatCityIdByCityUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShalatLocation>>> call(GetShalatCityIdByCityParams params) async {
    return await repository.getLocation(params.city);
  }
}

class GetShalatCityIdByCityParams extends Equatable {
  final String city;

  const GetShalatCityIdByCityParams({required this.city});

  @override
  List<Object?> get props => [city];
}
