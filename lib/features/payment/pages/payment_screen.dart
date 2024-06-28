import 'package:bloc_project/features/payment/widget/confirm_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/payment/bloc/payment_bloc.dart';
import 'package:bloc_project/features/payment/widget/payment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widget/payment_method.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);

  final List<String> paymentMethods = [
    'Net Banking',
    'UPI',
    'Card',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MediaQuery.of(context).size.width > 600
                ? Expanded(
                    flex: 3,
                    child: Image.asset(
                      'assets/book-doctor-appointment.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  AppTheme.sapdos,
                  SizedBox(height: 20.h),
                  const Text(
                    "Booking Appointment",
                    style: TextStyle(
                      color: AppPallete.gradient1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                        String? selectedPaymentMethod;
                        if (state is PaymentMethodSelected) {
                          selectedPaymentMethod = state.selectedPaymentMethod;
                        }

                        return PaymentDropdown(
                          paymentMethods: paymentMethods,
                          selectedPaymentMethod: selectedPaymentMethod,
                        );
                      },
                    ),
                  ),
                  const Text(
                    "Select the mode of Payment you prefer",
                    style: TextStyle(color: AppPallete.greyColor, fontSize: 12),
                  ),
                  BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      if (state is PaymentMethodSelected) {
                        return Column(
                          children: [
                            SizedBox(height: 30.h),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: PaymentCard(),
                            ),
                            SizedBox(height: 30.h),
                            Container(
                              decoration: BoxDecoration(
                                color: AppPallete.gradient1,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: AppPallete.whiteColor,
                                  backgroundColor: AppPallete.gradient1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<PaymentBloc>()
                                      .add(ConfirmPayment());
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const PaymentConfirmationDialog();
                                    },
                                  ).then((value) {
                                    context.go('/login');
                                  });
                                },
                                child: const Text("Pay Now"),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
