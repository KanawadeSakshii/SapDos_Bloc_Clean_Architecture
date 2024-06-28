part of 'signup_imports.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
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
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
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
                      SignupForm(),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          context.go("/login");
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already on Sapdos?",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                text: ' Sign-In ',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
