import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/payment/domain/entities/transaction_body_midtrans.codegen.dart';
import 'package:quranku/features/payment/domain/entities/transaction_midtrans.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/midtrans_repository.dart';
import '../dataSources/remote/midtrans_remote_data_source.dart';

@LazySingleton(as: MidtransRepository)
class MidtransRepositoryImpl implements MidtransRepository {
  final MidtransRemoteDataSource remoteDataSource;

  const MidtransRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TransactionMidtrans?>> getTransactionToken(
    TransactionBodyMidtrans body,
  ) async {
    try {
      final result = await remoteDataSource.getTokenTransactionResponse(
        transactionRequestModel: body.toModel(),
      );
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
