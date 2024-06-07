import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/auth/presentation/screens/login_screen.dart';
import 'package:bloc_project/features/auth/presentation/screens/signup_screen.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyWelcomePage extends StatelessWidget {
  //static const routeName = '/';

  const MyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/book-doctor-appointment.jpg',
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            flex: 3,
            child: Center(
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
                        height: 40,
                      ),
                      AppTheme.sapdos,
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        'Login to your sapdos account or \n create one now.',
                        style: TextStyle(
                            color: AppPallete.gradient1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthSubmitButton(
                        buttonText: 'LOGIN',
                        onTap: () {
                          // Navigator.pushNamed(context, '/login');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const LoginScreen(),
                          //   ),
                          // );
                          context.go('/login');
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
                              // Navigator.pushNamed(context, '/signup');
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const SignupScreen(),
                              //   ),
                              // );
                              context.go('/signup');
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
          ),
        ],
      ),
    );
  }
}
