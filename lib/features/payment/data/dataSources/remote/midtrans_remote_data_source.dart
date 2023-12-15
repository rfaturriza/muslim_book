import 'package:quranku/features/payment/data/models/transaction_request_model.codegen.dart';
import 'package:quranku/features/payment/data/models/transaction_response_model.codegen.dart';

abstract class MidtransRemoteDataSource {
  Future<TransactionResponseModel> getTokenTransactionResponse({
    TransactionRequestModel? transactionRequestModel,
  });
}
