import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kajian_schedule.codegen.dart';

@injectable
class GetProvincesUseCase
    implements UseCase<List<Province>, GetProvincesParams> {
  final KajianHubRepository repository;

  GetProvincesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Province>>> call(
    GetProvincesParams params,
  ) async {
    final result = await repository.getProvincesList(
      orderBy: params.orderBy,
      relations: params.relations,
      sortBy: params.sortBy,
      type: params.type,
    );
    return result;
  }
}

class GetProvincesParams extends Equatable {
  final String? type;
  final String? orderBy;
  final String? sortBy;
  final String? relations;

  const GetProvincesParams({
    this.type,
    this.orderBy,
    this.sortBy,
    this.relations,
  });

  @override
  List<Object?> get props => [type, orderBy, sortBy, relations];
}
