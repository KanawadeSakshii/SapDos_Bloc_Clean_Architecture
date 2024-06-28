import 'package:bloc_project/features/auth/data/model/user_login_model.dart';
import 'package:bloc_project/features/auth/data/model/user_response.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterRequested extends AuthEvent {
  final UserModel userRegister;

  const RegisterRequested({required this.userRegister});

  @override
  List<Object?> get props => [userRegister];
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  const AuthEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  const AuthPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class AuthNameChanged extends AuthEvent {
  final String name;

  const AuthNameChanged(
    this.name,
  );

  @override
  List<Object?> get props => [name];
}

class AuthPhoneNumberChanged extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;
  final String password;

  const AuthConfirmPasswordChanged(this.confirmPassword, this.password);

  @override
  List<Object?> get props => [confirmPassword];
}

class AuthRoleChanged extends AuthEvent {
  final String role;

  const AuthRoleChanged(this.role);

  @override
  List<Object?> get props => [role];
}

class LoginUser extends AuthEvent {
  final UserLoginModel login;
  final BuildContext context;

  const LoginUser({required this.login, required this.context});

  @override
  List<Object?> get props => [login];
}

class AutoLogin extends AuthEvent {
  final UserData userData;

  AutoLogin({required this.userData});
}

class RememberMeChanged extends AuthEvent {
  final bool value;

  RememberMeChanged(this.value);

  @override
  List<Object?> get props => [value];
}
