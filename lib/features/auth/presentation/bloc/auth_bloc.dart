import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RememberMeChanged>(_onRememberMeChanged);
    on<AuthLogin>(_onLogin);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));

    if (event.password != event.confirmPassword) {
      emit(AuthFailure("Passwords do not match"));
      return;
    }

    if (!_validateForm(event)) {
      emit(AuthFailure("Invalid form inputs"));
      return;
    }

    emit(AuthSuccess());
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));

    if (!_validateLoginForm(event)) {
      emit(AuthFailure("Invalid form inputs"));
      return;
    }

    emit(AuthSuccess());
  }

  void _onNameChanged(AuthNameChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(isNameValid: event.name.isNotEmpty));
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
        isEmailValid: EmailValidator.validate(event.email)));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
        isPasswordValid: _isPasswordValid(event.password)));
  }

  void _onConfirmPasswordChanged(
      AuthConfirmPasswordChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
        isConfirmPasswordValid: event.confirmPassword.isNotEmpty));
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  bool _validateForm(AuthSignUp event) {
    return event.name.isNotEmpty &&
        EmailValidator.validate(event.email) &&
        _isPasswordValid(event.password) &&
        event.password == event.confirmPassword;
  }

  bool _validateLoginForm(AuthLogin event) {
    return EmailValidator.validate(event.email) &&
        _isPasswordValid(event.password);
  }

  void _onRememberMeChanged(RememberMeChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(rememberMe: event.rememberMe));
  }
}
