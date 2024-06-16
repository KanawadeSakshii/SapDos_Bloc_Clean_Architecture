import 'package:flutter/material.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';

class PaymentConfirmationDialog extends StatelessWidget {
  const PaymentConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.gradient1,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: 300,
        padding: EdgeInsets.all(16),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppPallete.gradient1,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Oky.",
            style: TextStyle(color: AppPallete.gradient1),
          ),
        ),
      ],
    );
  }
}
