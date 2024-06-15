part of "signup_imports.dart";

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (builder) => const SignupScreen());

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final signupKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
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
              child: Container(
                decoration: const BoxDecoration(
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: signupKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            AppTheme.sapdos,
                            const SizedBox(height: 50),
                            const Text(
                              'Register',
                              style: TextStyle(
                                color: AppPallete.gradient1,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Enter New Account Details',
                              style: TextStyle(
                                color: AppPallete.greyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 35),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return Loader();
                                }
                                if (state is AuthSuccess) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    context.go('/patient');
                                  });
                                }
                                return Column(
                                  children: [
                                    AuthField(
                                      hintText: 'Enter Name',
                                      controller: nameController,
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(AuthNameChanged(value)),
                                      errorText: state is AuthFormState &&
                                              !state.isNameValid
                                          ? 'Name cannot be empty'
                                          : null,
                                    ),
                                    const SizedBox(height: 15),
                                    AuthField(
                                      hintText: 'Enter Email',
                                      controller: emailController,
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
                                      controller: passwordController,
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
                                    AuthField(
                                      hintText: 'Confirm Password',
                                      isObscureText: true,
                                      controller: confirmPasswordController,
                                      prefixIcon: Icons.lock,
                                      suffixIcon: Icons.visibility,
                                      iconColor: AppPallete.gradient1,
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(AuthConfirmPasswordChanged(
                                              value)),
                                      errorText: state is AuthFormState &&
                                              !state.isConfirmPasswordValid
                                          ? 'Passwords do not match'
                                          : null,
                                    ),
                                    const SizedBox(height: 15),
                                    AuthSubmitButton(
                                      buttonText: 'Sign Up',
                                      onTap: () {
                                        if (signupKey.currentState
                                                ?.validate() ??
                                            false) {
                                          context.read<AuthBloc>().add(
                                                AuthSignUp(
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  confirmPassword:
                                                      confirmPasswordController
                                                          .text,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    InkWell(
                                      onTap: () {
                                        context.go("/login");
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
                                                      decoration: TextDecoration
                                                          .underline)
                                                  .copyWith(
                                                      color:
                                                          AppPallete.gradient1,
                                                      fontWeight:
                                                          FontWeight.bold),
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
            ),
          ],
        ),
      ),
    );
  }
}
