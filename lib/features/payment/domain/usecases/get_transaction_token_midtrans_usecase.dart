import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/payment/domain/entities/transaction_midtrans.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/transaction_body_midtrans.codegen.dart';
import '../repositories/midtrans_repository.dart';

@injectable
class GetTransactionTokenMidtransUseCase
    implements
        UseCase<TransactionMidtrans?, GetTransactionTokenMidtransParams> {
  final MidtransRepository repository;

  GetTransactionTokenMidtransUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, TransactionMidtrans?>> call(
    GetTransactionTokenMidtransParams params,
  ) async {
    return await repository.getTransactionToken(params.body);
  }
}

class GetTransactionTokenMidtransParams extends Equatable {
  final TransactionBodyMidtrans body;

  const GetTransactionTokenMidtransParams({
    required this.body,
  });

  @override
  List<Object?> get props => [body];
}
