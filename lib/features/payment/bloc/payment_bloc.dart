import 'package:bloc/bloc.dart';
import 'package:bloc_project/features/payment/domain/payment_method.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  bool isDropdownOpened = false;

  PaymentBloc() : super(PaymentInitial()) {
    on<SelectPaymentMethod>((event, emit) {
      emit(PaymentMethodSelected(event.paymentMethod));
    });
    on<ConfirmPayment>((event, emit) {
      emit(PaymentConfirmed());
    });

    on<ToggleDropdown>((event, emit) {
      isDropdownOpened = !isDropdownOpened;
      emit(DropdownState(isDropdownOpened));
    });
  }
}
