import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_project/features/auth/presentation/screens/signup_screen.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_project/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:bloc_project/features/patient/presentation/pages/patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (builder) => const LoginScreen());

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
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
                          const SizedBox(height: 10),
                          AppTheme.sapdos,
                          const SizedBox(height: 50),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: AppPallete.gradient1,
                              fontSize: 25,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Enter existing account's details",
                            style: TextStyle(
                              color: AppPallete.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 30),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthSuccess) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientScreen()),
                                  );
                                });
                              }

                              return Column(
                                children: [
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
                                  const SizedBox(height: 15),
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
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: 300,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            BlocBuilder<AuthBloc, AuthState>(
                                              builder: (context, state) {
                                                bool rememberMe =
                                                    state is AuthFormState
                                                        ? state.rememberMe
                                                        : false;

                                                return Checkbox(
                                                  value: rememberMe,
                                                  onChanged: (value) {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(RememberMeChanged(
                                                            value!));
                                                  },
                                                );
                                              },
                                            ),
                                            const Text('Remember Me'),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Forgotten Password?",
                                            style: TextStyle(
                                              color: AppPallete.gradient1,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                  AuthSubmitButton(
                                    buttonText: 'Login',
                                    onTap: () {
                                      if (signupKey.currentState?.validate() ??
                                          false) {
                                        context.read<AuthBloc>().add(AuthLogin(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ));
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, SignupScreen.route());
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Not on SapDos ?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        children: [
                                          TextSpan(
                                            text: ' Sign-Up ',
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ).copyWith(
                                              color: AppPallete.gradient1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
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
