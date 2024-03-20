import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/kajian/data/repositories/kajianhub_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kajian_schedule.codegen.dart';

@injectable
class GetKajianThemesUseCase
    implements UseCase<List<KajianTheme>, GetKajianThemesParams> {
  final KajianHubRepository repository;

  GetKajianThemesUseCase(this.repository);

  @override
  Future<Either<Failure, List<KajianTheme>>> call(
    GetKajianThemesParams params,
  ) async {
    final result = await repository.getKajianThemesList(
      orderBy: params.orderBy,
      sortBy: params.sortBy,
      type: params.type,
    );
    return result;
  }
}

class GetKajianThemesParams extends Equatable {
  final String? type;
  final String? orderBy;
  final String? sortBy;
  final String? relations;

  const GetKajianThemesParams({
    this.type,
    this.orderBy,
    this.sortBy,
    this.relations,
  });

  @override
  List<Object?> get props => [type, orderBy, sortBy, relations];
}
