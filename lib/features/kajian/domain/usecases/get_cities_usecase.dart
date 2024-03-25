import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kajian_schedule.codegen.dart';

@injectable
class GetCitiesUseCase
    implements UseCase<List<City>, GetCitiesParams> {
  final KajianHubRepository repository;

  GetCitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(
    GetCitiesParams params,
  ) async {
    final result = await repository.getCitiesList(
      orderBy: params.orderBy,
      relations: params.relations,
      sortBy: params.sortBy,
      type: params.type,
    );
    return result;
  }
}

class GetCitiesParams extends Equatable {
  final String? type;
  final String? orderBy;
  final String? sortBy;
  final String? relations;

  const GetCitiesParams({
    this.type,
    this.orderBy,
    this.sortBy,
    this.relations,
  });

  @override
  List<Object?> get props => [type, orderBy, sortBy, relations];
}
