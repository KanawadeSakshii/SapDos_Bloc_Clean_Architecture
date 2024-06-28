part of 'login_imports.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final signupKey = GlobalKey<FormState>();

    final AuthBloc authBloc = serviceLocator<AuthBloc>();

    return BlocProvider(
      create: (context) => authBloc,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width > 600
                            ? 50.0
                            : 20.0,
                      ),
                      child: Form(
                        key: signupKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            AppTheme.sapdos,
                            const SizedBox(height: 50),
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: AppPallete.gradient1,
                                fontSize: 20,
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
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthLoading) {
                                } else if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Successful'),
                                      backgroundColor: AppPallete.succesColor,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else if (state is AuthFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: AppPallete.errorColor,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
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
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 300
                                                : double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BlocBuilder<AuthBloc, AuthState>(
                                              builder: (context, state) {
                                                bool rememberMe =
                                                    state is AuthSuccess
                                                        ? state.rememberMe
                                                        : false;

                                                return Row(
                                                  children: [
                                                    Checkbox(
                                                      value: rememberMe,
                                                      onChanged: (value) {
                                                        context
                                                            .read<AuthBloc>()
                                                            .add(
                                                                RememberMeChanged(
                                                                    value!));
                                                      },
                                                      activeColor:
                                                          AppPallete.gradient1,
                                                    ),
                                                    const Text(
                                                      "Remember Me",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "Forgotten Password?",
                                                style: TextStyle(
                                                  fontSize: 12,
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
                                          if (signupKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            context.read<AuthBloc>().add(
                                                  LoginUser(
                                                    login: UserLoginModel(
                                                      userName:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    ),
                                                    context: context,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      InkWell(
                                        onTap: () {
                                          context.go("/signup");
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
