part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class SelectPaymentMethod extends PaymentEvent {
  final String paymentMethod;

  const SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}

class ConfirmPayment extends PaymentEvent {}
