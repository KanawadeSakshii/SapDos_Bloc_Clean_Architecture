import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class MyWelcomePage extends StatelessWidget {
  const MyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                AppTheme.sapdos,
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Login to your sapdos account or \n create one now.',
                  style: TextStyle(
                      color: AppPallete.gradient1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                AuthSubmitButton(
                  buttonText: 'LOGIN',
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppPallete.gradient1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppPallete.transparentColor,
                          shadowColor: AppPallete.transparentColor,
                          fixedSize: const Size(350, 40)),
                      child: const Text(
                        'SIGN-UP',
                        style: TextStyle(
                            color: AppPallete.gradient1,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Proceed as a Guest',
                    style: TextStyle(
                        color: AppPallete.gradient1,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
