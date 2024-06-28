import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:bloc_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_project/features/auth/presentation/widgets/role_dropdown.dart';
import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:go_router/go_router.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController issuedescriptionController =
      TextEditingController();

  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        UserRole role = UserRole.doctor;

        if (state is AuthFormState) {
          role = state.role;
        }

        return Form(
          key: signupKey,
          child: Column(
            children: [
              AuthField(
                hintText: 'Enter Name',
                controller: nameController,
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthNameChanged(value)),
                errorText: state is AuthFormState && !state.isNameValid
                    ? 'Name cannot be empty'
                    : null,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: 'Enter Email',
                controller: emailController,
                prefixIcon: Icons.email,
                iconColor: AppPallete.gradient1,
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthEmailChanged(value)),
                errorText: state is AuthFormState && !state.isEmailValid
                    ? 'Invalid email'
                    : null,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: 'Enter Phone Number',
                controller: phoneController,
                prefixIcon: Icons.phone,
                iconColor: AppPallete.gradient1,
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthPhoneNumberChanged(value)),
                errorText: state is AuthFormState && !state.isPhoneNumberValid
                    ? 'Invalid phone number'
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
                onChanged: (value) =>
                    context.read<AuthBloc>().add(AuthPasswordChanged(value)),
                errorText: state is AuthFormState && !state.isPasswordValid
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
                onChanged: (value) => context.read<AuthBloc>().add(
                    AuthConfirmPasswordChanged(value, passwordController.text)),
                errorText:
                    state is AuthFormState && !state.isConfirmPasswordValid
                        ? 'Passwords do not match'
                        : null,
              ),
              const SizedBox(height: 15),
              RoleDropdown(
                selectedRole: role,
                onChanged: (UserRole? value) {
                  String roleName = value?.name ?? '';
                  context.read<AuthBloc>().add(AuthRoleChanged(roleName));
                },
              ),
              const SizedBox(height: 15),
              if (role == UserRole.patient) ...[
                AuthField(
                  hintText: 'Enter Age',
                  controller: ageController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Enter Disease',
                  controller: diseaseController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Enter Issue Description',
                  controller: issuedescriptionController,
                ),
              ],
              if (role == UserRole.doctor) ...[
                AuthField(
                  hintText: 'Enter Experience',
                  controller: experienceController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Enter Specialization',
                  controller: specializationController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Enter Description',
                  controller: descriptionController,
                ),
              ],
              const SizedBox(height: 15),
              AuthSubmitButton(
                buttonText: 'Sign Up',
                onTap: () {
                  // Validate the form using the GlobalKey
                  if (signupKey.currentState?.validate() ?? false) {
                    context.read<AuthBloc>().add(
                          RegisterRequested(
                            userRegister: UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              mobileNumber: phoneController.text,
                              password: passwordController.text,
                              confirmpassword: confirmPasswordController.text,
                              role: role,
                              experience: role == UserRole.doctor
                                  ? int.tryParse(experienceController.text)
                                  : null,
                              specialization: specializationController.text,
                              description: descriptionController.text,
                              age: ageController.text,
                              disease: diseaseController.text,
                            ),
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration Successful'),
                        backgroundColor: AppPallete.succesColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    context.go('/login');
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
        );
      },
    );
  }
}
