import 'package:bloc_project/core/common/widget/loader.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:bloc_project/core/theme/theme.dart';
import 'package:bloc_project/core/utils/snackbar.dart';
import 'package:bloc_project/features/authenticate/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/authenticate/presentation/pages/login_page.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/authenticate/presentation/widgets/auth_field.dart';
import 'package:bloc_project/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (builder) => SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final signupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailuare) {
                  showSnackBAr(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                } else if (state is AuthSuccess) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DoctorScreen()));
                }
                return Form(
                  key: signupKey,
                  child: Column(
                    children: [
                      AppTheme.sapdos,
                      const SizedBox(
                        height: 20,
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
                      AuthField(
                        hintText: 'Enter Name',
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 15,
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
                      AuthField(
                        hintText: 'Confirm Password',
                        isObscureText: true,
                        controller: _confirmPasswordController,
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.visibility,
                        iconColor: AppPallete.gradient1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthSubmitButton(
                        buttonText: 'Sign Up',
                        onTap: () {
                          if (signupKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignUp(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  confirmPassword:
                                      _confirmPasswordController.text.trim(),
                                ));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, LoginPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already on Sapdos?",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                    text: ' Sign-In ',
                                    style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline)
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
      ),
    );
  }
}
