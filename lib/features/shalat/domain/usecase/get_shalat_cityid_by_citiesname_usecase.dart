import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/features/shalat/domain/repositories/location_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../generated/locale_keys.g.dart';
import '../entities/shalat_location.codegen.dart';
import 'get_shalat_cityid_by_cityname_usecase.dart';

@injectable
class GetShalatCityIdByCitiesUseCase
    implements UseCase<List<ShalatLocation>?, GetShalatCityIdByCitiesParams> {
  final LocationRepository repository;
  final GetShalatCityIdByCityUseCase getCityId;

  GetShalatCityIdByCitiesUseCase(this.repository, this.getCityId);

  @override
  Future<Either<Failure, List<ShalatLocation>>> call(
      GetShalatCityIdByCitiesParams params) async {
    if (params.cities == null) {
      return Left(GeneralFailure(message: LocaleKeys.locationNotFound.tr()));
    }

    for (final city in (params.cities ?? [])) {
      final result = await getCityId(
        GetShalatCityIdByCityParams(city: city),
      );
      if (result.isRight()) {
        return Right(result.asRight());
      }
    }

    return Left(GeneralFailure(message: LocaleKeys.locationNotFound.tr()));
  }
}

class GetShalatCityIdByCitiesParams extends Equatable {
  final List<String>? cities;

  const GetShalatCityIdByCitiesParams({required this.cities});

  @override
  List<Object?> get props => [cities];
}
