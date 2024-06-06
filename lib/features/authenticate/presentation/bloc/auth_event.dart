part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthSignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  // TODO: implement props
  List<Object> get props => [name, email, password, confirmPassword];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}
