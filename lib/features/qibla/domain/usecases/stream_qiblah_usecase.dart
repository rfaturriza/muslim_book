import 'package:dartz/dartz.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class StreamQiblaUseCase extends StreamUseCase<QiblahDirection, NoParams> {
  @override
  Stream<Either<Failure, QiblahDirection>> call(NoParams params) {
    return FlutterQiblah.qiblahStream.map((event) => Right(event));
  }
}
