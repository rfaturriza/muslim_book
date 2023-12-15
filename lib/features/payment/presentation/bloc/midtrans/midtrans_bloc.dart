import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/payment/domain/usecases/get_transaction_token_midtrans_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/transaction_body_midtrans.codegen.dart';
import '../../../domain/entities/transaction_midtrans.codegen.dart';

part 'midtrans_bloc.freezed.dart';

part 'midtrans_event.dart';

part 'midtrans_state.dart';

@injectable
class MidtransBloc extends Bloc<MidtransEvent, MidtransState> {
  final GetTransactionTokenMidtransUseCase getToken;

  MidtransBloc(
    this.getToken,
  ) : super(const MidtransState()) {
    on<_PurchaseEvent>(_onPurchase);
  }

  FutureOr<void> _onPurchase(
    _PurchaseEvent event,
    Emitter<MidtransState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    final result = await getToken(
      GetTransactionTokenMidtransParams(
        body: TransactionBodyMidtrans(
          orderId: DateTime.now().millisecondsSinceEpoch.toString(),
          grossAmount: event.grossAmount,
          secureCreditCard: true,
        ),
      ),
    );
    emit(state.copyWith(
      status: FormzSubmissionStatus.success,
      transaction: result,
    ));
  }
}
