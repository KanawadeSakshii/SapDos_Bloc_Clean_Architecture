import 'package:bloc_project/features/authenticate/presentation/pages/login_page.dart';
import 'package:bloc_project/features/authenticate/presentation/pages/signup_page.dart';
import 'package:bloc_project/features/authenticate/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MediaQuery.of(context).size.width > 600
              ? Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/book-doctor-appointment.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: 3,
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(builder: (context) {
                  switch (settings.name) {
                    case LoginPage.routeName:
                      return const LoginPage();
                    case SignupPage.routeName:
                      return const SignupPage();
                    default:
                      return const MyWelcomePage();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
