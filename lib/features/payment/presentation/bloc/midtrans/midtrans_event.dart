part of 'midtrans_bloc.dart';

@freezed
class MidtransEvent with _$MidtransEvent {
  const factory MidtransEvent.purchaseEvent(
    int grossAmount,
  ) = _PurchaseEvent;
}
