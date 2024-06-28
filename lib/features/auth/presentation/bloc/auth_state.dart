import 'package:bloc_project/features/auth/data/model/user_response.dart';
import 'package:bloc_project/features/auth/presentation/widgets/error_code.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;
  final String role;
  bool rememberMe;

  AuthSuccess({this.rememberMe = false, required this.uid, required this.role});
  AuthSuccess copyWith({
    String? uid,
    String? role,
    bool? rememberMe,
  }) {
    return AuthSuccess(
      uid: uid ?? this.uid,
      role: role ?? this.role,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [uid, role, rememberMe];
}

class AuthFailure extends AuthState {
  final AuthErrorCode errorCode;

  final String message;

  const AuthFailure({required this.errorCode, this.message = ''});

  @override
  List<Object?> get props => [message];
}

class AuthFormState extends AuthState {
  final UserRole role;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNameValid;
  final bool isPhoneNumberValid;
  final bool isConfirmPasswordValid;
  final bool isRoleValid;

  AuthFormState({
    this.role = UserRole.doctor,
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.isNameValid = true,
    this.isPhoneNumberValid = true,
    this.isConfirmPasswordValid = true,
    this.isRoleValid = true,
  });

  AuthFormState copyWith({
    UserRole? role,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isNameValid,
    bool? isPhoneNumberValid,
    bool? isConfirmPasswordValid,
    bool? isRoleValid,
  }) {
    return AuthFormState(
      role: role ?? this.role,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isRoleValid: isRoleValid ?? this.isRoleValid,
    );
  }

  @override
  List<Object?> get props => [
        isEmailValid,
        isPasswordValid,
        isNameValid,
        isPhoneNumberValid,
        isConfirmPasswordValid,
        isRoleValid,
      ];
}

class AuthLoggedIn extends AuthState {
  final UserData userData;

  const AuthLoggedIn({required this.userData});

  @override
  List<Object?> get props => [userData];
}
