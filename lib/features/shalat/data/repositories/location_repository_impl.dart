import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/features/shalat/domain/entities/shalat_location.codegen.dart';

import '../../domain/repositories/location_repository.dart';
import '../dataSources/remote/shalat_remote_data_source.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final ShalatRemoteDataSource remoteDataSource;

  const LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ShalatLocation>>> getLocation(String city) async {
    final result = await remoteDataSource.getShalatLocation(city);
    return result.fold((error) => left(error), (r) => right(r.toEntity()));
  }
}
