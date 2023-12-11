import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

@injectable
class StreamPaymentInAppPurchaseUseCase extends StreamUseCase<List<PurchaseDetails>, NoParams> {
  final InAppPurchase inAppPurchase;
  StreamPaymentInAppPurchaseUseCase(this.inAppPurchase);

  @override
  Stream<Either<Failure, List<PurchaseDetails>>> call(NoParams params) {
    return inAppPurchase.purchaseStream.map((event) => Right(event));
  }
}
