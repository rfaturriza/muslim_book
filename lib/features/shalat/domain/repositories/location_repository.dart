import 'package:dartz/dartz.dart';
import 'package:quranku/core/error/failures.dart';
import 'package:quranku/features/shalat/domain/entities/shalat_location.codegen.dart';

abstract class LocationRepository {
  Future<Either<Failure,List<ShalatLocation>>> getLocation(String city);
}