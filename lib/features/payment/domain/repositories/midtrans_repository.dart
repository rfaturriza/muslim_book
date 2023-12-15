import 'package:dartz/dartz.dart';
import 'package:quranku/features/payment/domain/entities/transaction_body_midtrans.codegen.dart';
import 'package:quranku/features/payment/domain/entities/transaction_midtrans.codegen.dart';

import '../../../../core/error/failures.dart';

abstract class MidtransRepository {
  Future<Either<Failure, TransactionMidtrans?>> getTransactionToken(
    TransactionBodyMidtrans body,
  );
}
