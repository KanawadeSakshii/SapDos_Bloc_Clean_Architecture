import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/core/utils/snackbar.dart';
import 'package:bloc_project/features/authenticate/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/authenticate/presentation/pages/signup_page.dart';
import 'package:bloc_project/features/authenticate/presentation/pages/welcome_page.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final signinKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailuare) {
                showSnackBAr(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyWelcomePage(),
                    ));
                // pushAndRemoveUntil(
                //   context,
                //   BlogPage.route(),
                //   (route) => false,
                // );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Form(
                key: signinKey,
                child: Column(
                  children: [
                    AppTheme.sapdos,
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: AppPallete.gradient1,
                          fontSize: 25,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Enter existing account's details",
                      style: TextStyle(
                          color: AppPallete.greyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintText: 'Enter Email',
                      controller: _emailController,
                      prefixIcon: Icons.email,
                      iconColor: AppPallete.gradient1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: 'Enter Password',
                      isObscureText: true,
                      controller: _passwordController,
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility,
                      iconColor: AppPallete.gradient1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  }),
                              const Text('Remember Me'),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgotten Password?",
                                style: TextStyle(
                                    color: AppPallete.gradient1,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthSubmitButton(
                      buttonText: 'LOGIN',
                      onTap: () {
                        if (signinKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, SignupPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Not on sapdos ?",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                  text: ' Sign Up ',
                                  style: const TextStyle(
                                          decoration: TextDecoration.underline)
                                      .copyWith(
                                          color: AppPallete.gradient1,
                                          fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
