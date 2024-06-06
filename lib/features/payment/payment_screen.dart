import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/payment/payment_card.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  bool isDropdownOpened = false;
  bool paymentSuccess = true;

  final List<String> paymentMethod = [
    'Net Banking',
    'UPI',
    'Card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(
                    height: 60,
                  ),
                  AppTheme.sapdos,
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Booking Appointment",
                    style: const TextStyle(
                        color: AppPallete.gradient1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownMenu(
                        initialValue: selectedPaymentMethod,
                        items: paymentMethod
                            .map((method) => DropdownMenuItem(
                                value: method, child: Text(method)))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPaymentMethod = newValue;
                          });
                        },
                      )),
                  const Text(
                    "Select the mode of Payment you prefer",
                    style: TextStyle(color: AppPallete.greyColor, fontSize: 12),
                  ),
                  if (selectedPaymentMethod != null)
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: PaymentCard(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppPallete.gradient1,
                              borderRadius: BorderRadius.circular(5)),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: AppPallete.whiteColor,
                                  backgroundColor: AppPallete.gradient1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppPallete.gradient1,
                                      contentPadding: EdgeInsets.all(0),
                                      content: Container(
                                        height:
                                            300, // Set the desired height here
                                        padding: EdgeInsets.all(16),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.price_check_outlined,
                                              size: 50,
                                              color: AppPallete.whiteColor,
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              "Your booking is confirmed",
                                              style: TextStyle(
                                                color: AppPallete.whiteColor,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            // Add more content here if needed
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                AppPallete.gradient1,
                                            backgroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Oky.",
                                            style: TextStyle(
                                                color: AppPallete.gradient1),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("pay Now")),
                        )
                      ],
                    )
                ],
              )),
        ],
      ),
    );
  }
}

class DropdownMenu extends StatefulWidget {
  final String? initialValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;

  const DropdownMenu({
    Key? key,
    required this.items,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isDropdownOpened = !isDropdownOpened;
            });
          },
          child: Container(
            height: 50,
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
                    widget.initialValue ?? 'Select',
                    style: TextStyle(fontSize: 16),
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
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      isDropdownOpened = false;
                      if (widget.onChanged != null) {
                        widget.onChanged!(widget.items[index].value);
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: widget.items[index].child,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
