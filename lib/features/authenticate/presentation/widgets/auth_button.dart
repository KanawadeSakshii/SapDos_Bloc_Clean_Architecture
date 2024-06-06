import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthSubmitButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: AppPallete.gradient1, borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
            fixedSize: const Size(350, 40)),
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
      ),
    );
  }
}
