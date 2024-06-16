import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/features/payment/bloc/payment_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDropdown extends StatelessWidget {
  final List<String> paymentMethods;
  final String? selectedPaymentMethod;

  const PaymentDropdown({
    Key? key,
    required this.paymentMethods,
    this.selectedPaymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        bool isDropdownOpened = false;
        if (state is DropdownState) {
          isDropdownOpened = state.isDropdownOpened;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.read<PaymentBloc>().add(ToggleDropdown());
              },
              child: Container(
                height: 50.h,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppPallete.gradient1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPaymentMethod ?? 'Select',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Icon(isDropdownOpened
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            if (isDropdownOpened)
              Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.builder(
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<PaymentBloc>().add(ToggleDropdown());
                        context
                            .read<PaymentBloc>()
                            .add(SelectPaymentMethod(paymentMethods[index]));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(paymentMethods[index]),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
