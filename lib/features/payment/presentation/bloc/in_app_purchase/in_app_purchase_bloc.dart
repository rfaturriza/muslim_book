import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/payment/domain/usecases/stream_payment_in_app_purchase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

part 'in_app_purchase_bloc.freezed.dart';

part 'in_app_purchase_event.dart';

part 'in_app_purchase_state.dart';

@injectable
class InAppPurchaseBloc extends Bloc<InAppPurchaseEvent, InAppPurchaseState> {
  final InAppPurchase inAppPurchase;
  final StreamPaymentInAppPurchaseUseCase streamPaymentPurchase;
  StreamSubscription<Either<Failure, List<PurchaseDetails>>>?
      _subscriptionPurchase;

  InAppPurchaseBloc(
    this.inAppPurchase,
    this.streamPaymentPurchase,
  ) : super(const InAppPurchaseState()) {
    _streamPurchaseChanges();

    on<_Initialize>(_onInitialize);
    on<_StreamPurchaseEvent>(_onStreamPurchaseEvent);
    on<_PurchaseConsumable>(_onPurchaseConsumable);
    on<_PurchaseNonConsumable>(_onPurchaseNonConsumable);
    on<_PurchaseSubscription>(_onPurchaseSubscription);
  }

  void _streamPurchaseChanges() {
    _subscriptionPurchase = streamPaymentPurchase(NoParams()).listen(
      (event) {
        final List<PurchaseDetails> listPurchase =
            event.isRight() ? event.getOrElse(() => []) : [];
        add(InAppPurchaseEvent.streamPurchaseEvent(listPurchase));
      },
    );
  }

  static final _variant = <String>[
    'donate_1',
    'donate_10',
    'donate_100',
  ];

  void _onInitialize(
    _Initialize event,
    Emitter<InAppPurchaseState> emit,
  ) async {
    emit(state.copyWith(initStatus: FormzSubmissionStatus.inProgress));
    final available = await inAppPurchase.isAvailable();
    if (available) {
      final response = await inAppPurchase.queryProductDetails(
        _variant.toSet(),
      );
      if (response.notFoundIDs.isNotEmpty) {
        emit(state.copyWith(
          isAvailable: available,
          initStatus: FormzSubmissionStatus.failure,
          errorMessage: "Product not found",
        ));
      }
      final products = response.productDetails;
      products.sort((a, b) => a.id.compareTo(b.id));
      emit(state.copyWith(
        isAvailable: available,
        products: products,
      ));
    } else {
      emit(state.copyWith(
        isAvailable: available,
      ));
    }
  }

  void _onStreamPurchaseEvent(
    _StreamPurchaseEvent event,
    Emitter<InAppPurchaseState> emit,
  ) async {
    final purchaseDetails = event.purchaseDetails;
    if (purchaseDetails.isNotEmpty) {
      final purchaseDetail = purchaseDetails.first;
      emit(state.copyWith(
        purchaseStatus: purchaseDetail.status,
        purchases: purchaseDetails,
      ));
    }
  }

  void _onPurchaseConsumable(
    _PurchaseConsumable event,
    Emitter<InAppPurchaseState> emit,
  ) async {
    emit(state.copyWith(purchaseStatus: PurchaseStatus.pending));
    final purchaseParam = PurchaseParam(
      productDetails: event.productDetails,
    );
    try {
      await inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      emit(state.copyWith(
        purchaseStatus: PurchaseStatus.error,
      ));
    }
  }

  void _onPurchaseNonConsumable(
    _PurchaseNonConsumable event,
    Emitter<InAppPurchaseState> emit,
  ) async {
    emit(state.copyWith(purchaseStatus: PurchaseStatus.pending));
    final purchaseParam = PurchaseParam(
      productDetails: event.productDetails,
    );
    await inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  void _onPurchaseSubscription(
    _PurchaseSubscription event,
    Emitter<InAppPurchaseState> emit,
  ) async {
    emit(state.copyWith(purchaseStatus: PurchaseStatus.pending));
    final productDetails = state.products.first;
    final purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );
  }

  @override
  Future<void> close() {
    _subscriptionPurchase?.cancel();
    return super.close();
  }
}
