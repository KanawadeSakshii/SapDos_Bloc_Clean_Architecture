import 'package:flutter/material.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final IconData trailingIcon;

  const CustomAnimatedContainer({
    Key? key,
    required this.text,
    this.leadingIcon,
    required this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppPallete.gradient1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  leadingIcon,
                  color: AppPallete.whiteColor,
                  size: 22,
                ),
                const SizedBox(width: 10),
                AnimatedDefaultTextStyle(
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Text(text),
                ),
              ],
            ),
            Icon(
              trailingIcon,
              color: AppPallete.whiteColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}