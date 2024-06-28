import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWelcomePage extends StatelessWidget {
  const MyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.gradient4,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/sapdos.png',
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      AppTheme.sapdos,
                      SizedBox(
                        height: 100.h,
                      ),
                      Text(
                          'Login to your sapdos account or \n               create one now.',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: AppPallete.gradient1,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      AuthSubmitButton(
                        buttonText: 'LOGIN',
                        onTap: () {
                          context.go('/login');
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppPallete.gradient1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2),
                            )),
                      ),
                      SizedBox(
                        height: 40.h,
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
