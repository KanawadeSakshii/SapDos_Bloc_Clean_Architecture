import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFormState extends AuthState {
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool rememberMe;

  AuthFormState({
    this.isNameValid = true,
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.isConfirmPasswordValid = true,
    this.rememberMe = false,
  });

  AuthFormState copyWith({
    bool? isNameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? rememberMe,
  }) {
    return AuthFormState(
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [
        isNameValid,
        isEmailValid,
        isPasswordValid,
        isConfirmPasswordValid,
      ];
}
