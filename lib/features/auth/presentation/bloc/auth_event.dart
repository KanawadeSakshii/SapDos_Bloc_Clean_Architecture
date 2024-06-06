import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [name, email, password, confirmPassword];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthNameChanged extends AuthEvent {
  final String name;

  AuthNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class AuthConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;

  AuthConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class RememberMeChanged extends AuthEvent {
  final bool rememberMe;

  RememberMeChanged(this.rememberMe);
}
