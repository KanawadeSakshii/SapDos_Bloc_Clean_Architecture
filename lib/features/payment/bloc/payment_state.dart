part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentMethodSelected extends PaymentState {
  final String selectedPaymentMethod;
  const PaymentMethodSelected(this.selectedPaymentMethod);
  @override
  List<Object> get props => [selectedPaymentMethod];
}

class PaymentConfirmed extends PaymentState {}

class DropdownState extends PaymentState {
  final bool isDropdownOpened;

  DropdownState(this.isDropdownOpened);

  @override
  List<Object> get props => [isDropdownOpened];
}
