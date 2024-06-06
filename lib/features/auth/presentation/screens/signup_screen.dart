import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_project/features/auth/presentation/screens/login_screen.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_project/features/doctor/presentation/pages/doctor_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (builder) => const SignupScreen());
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final signupKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: signupKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          AppTheme.sapdos,
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Register',
                            style: TextStyle(
                                color: AppPallete.gradient1,
                                fontSize: 25,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Enter New Account Details',
                            style: TextStyle(
                                color: AppPallete.greyColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return Loader();
                              }
                              if (state is AuthSuccess) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DoctorScreen()));
                                });
                              }
                              return Column(
                                children: [
                                  AuthField(
                                    hintText: 'Enter Name',
                                    controller: _nameController,
                                    onChanged: (value) => context
                                        .read<AuthBloc>()
                                        .add(AuthNameChanged(value)),
                                    errorText: state is AuthFormState &&
                                            !state.isNameValid
                                        ? 'Name cannot be empty'
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthField(
                                    hintText: 'Enter Email',
                                    controller: _emailController,
                                    prefixIcon: Icons.email,
                                    iconColor: AppPallete.gradient1,
                                    onChanged: (value) => context
                                        .read<AuthBloc>()
                                        .add(AuthEmailChanged(value)),
                                    errorText: state is AuthFormState &&
                                            !state.isEmailValid
                                        ? 'Invalid email'
                                        : null,
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
                                    onChanged: (value) => context
                                        .read<AuthBloc>()
                                        .add(AuthPasswordChanged(value)),
                                    errorText: state is AuthFormState &&
                                            !state.isPasswordValid
                                        ? 'Invalid password'
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthField(
                                    hintText: 'Confirm Password',
                                    isObscureText: true,
                                    controller: _confirmPasswordController,
                                    prefixIcon: Icons.lock,
                                    suffixIcon: Icons.visibility,
                                    iconColor: AppPallete.gradient1,
                                    onChanged: (value) => context
                                        .read<AuthBloc>()
                                        .add(AuthConfirmPasswordChanged(value)),
                                    errorText: state is AuthFormState &&
                                            !state.isConfirmPasswordValid
                                        ? 'Passwords do not match'
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AuthSubmitButton(
                                    buttonText: 'Sign Up',
                                    onTap: () {
                                      if (signupKey.currentState?.validate() ??
                                          false) {
                                        context.read<AuthBloc>().add(AuthSignUp(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              confirmPassword:
                                                  _confirmPasswordController
                                                      .text,
                                            ));
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, LoginScreen.route());
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Already on Sapdos?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          children: [
                                            TextSpan(
                                                text: ' Sign-In ',
                                                style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline)
                                                    .copyWith(
                                                        color: AppPallete
                                                            .gradient1,
                                                        fontWeight:
                                                            FontWeight.bold))
                                          ]),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
