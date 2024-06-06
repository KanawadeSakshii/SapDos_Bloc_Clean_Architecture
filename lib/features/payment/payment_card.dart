import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentCard extends StatelessWidget {
  //TextEditingController cardNumberController = TextEditingController();
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Enter your details below",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12)
                  ],
                  decoration: const InputDecoration(
                    hintText: "Card Number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Icon(Icons.call_to_action_rounded),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Card Holder",
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "MM/YY"),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(hintText: "CVV"),
                    ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
